//
//  MainViewModel.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/10.
//

import UIKit
import RxSwift
import RxCocoa
import ColorKit
import UIImageColors

class MainViewModel {
    
    let disposeBag = DisposeBag()
    var dependency: String = ""
    var input: Input
    var output: Output
    
    
    init(dependency: String) {
        self.dependency = dependency
        
        input = Input(loadingEndAction: nil,
                      userLogin: BehaviorSubject<LoginInfo>(value: LoginInfo(id: 1, name: "s")),
                      willMosaicImage: PublishSubject<UIImage>(),
                      tapGridColor: PublishSubject<GridColor>(),
                      addImage: PublishSubject<UIImage>(),
                      makeMosaicImage: BehaviorSubject<Bool>(value: false))
        
        output = Output(mosaicedImages: BehaviorSubject<[MosaicImage]>(value: [MosaicImage]()),
                        colletedColors: BehaviorSubject<[GridColor]>(value: [GridColor]()),
                        colorIngredients: BehaviorSubject<[GridColor]>(value: [GridColor]()),
                        myImageCollection: BehaviorSubject<[Image]>(value: [Image]()),
                        imageForGridColor: BehaviorSubject<[Image]>(value: [Image]()))
        
        input.userLogin
            .filter { "\($0.id)" != "bbj" }
            .subscribe { loginInfo in
                guard let name = loginInfo.element?.name else { return }
                Network.shared.connect(type: .login(name))
                    .subscribe { response in
                        switch response {
                        case .success(let data):
                            //print(String(data: data as! Data, encoding: .utf8))
                            guard let myId = data as? CommonRes<LoginInfo> else { return }
                            User.myId = "\(myId.data.id)"
                            
                            Network.shared.connect(type: .getPhoto)
                                .subscribe { response in
                                    switch response {
                                    case .success(let data):
                                        guard let myPhotos = data as? CommonResWithArray<Image> else { return }
                                        self.output.myImageCollection.onNext(myPhotos.data)
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                .disposed(by: self.disposeBag)
                            
                            Network.shared.connect(type: .getMosaicImage)
                                .subscribe { response in
                                    switch response {
                                    case .success(let data):
                                        guard let myPhots = data as? CommonResWithArray<MosaicImage> else { return }
                                        self.output.mosaicedImages.onNext(myPhots.data)
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                .disposed(by: self.disposeBag)
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        input.addImage
            .subscribe { image in
                let color = GridColor.measureSimilarity(color: image.getColors()!.background)
                print(color)
                Network.shared.connect(type: .imageUpload(color, image))
                    .subscribe { response in
                        switch response {
                        case .success(_):
                            print("scucce")
                            print("-----------------")
                            Network.shared.connect(type: .getPhoto)
                                .subscribe { response in
                                    switch response {
                                    case .success(let data):
                                        guard let myPhotos = data as? CommonResWithArray<Image> else { return }
                                        self.output.myImageCollection.onNext(myPhotos.data)
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                .disposed(by: self.disposeBag)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        input.tapGridColor
            .flatMapLatest { color in
                self.output.myImageCollection
                    .map { imageSet in
                        return imageSet.filter{ $0.color == color.rawValue }
                    }
            }
            .subscribe { color in
                self.output.imageForGridColor.onNext(color)
            }
            .disposed(by: disposeBag)
        
        input.willMosaicImage
            .observe(on: ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
            .flatMapLatest { image  in
                let colorList = image.SplitGrid(times: 10)
                return GridColor.measureSimilarity(colors: colorList)
            }
            .subscribe { [weak self] gridColors in
                self?.input.loadingEndAction!()
                self?.output.colorIngredients.onNext(gridColors)
            }
            .disposed(by: disposeBag)
        
        input.makeMosaicImage
            .filter { $0 == true }
            .flatMap { _ in Observable.combineLatest(self.output.colorIngredients, self.input.willMosaicImage) }
            .debug()
            .subscribe { colors, image in
                Network.shared.connect(type: .generateMosaic(colors, image))
                    .subscribe { response in
                        switch response {
                        case .success(let data):
                            guard let myPhotos = data as? CommonRes<MosaicImage> else { return }
                            print(myPhotos.data)
                            self.input.loadingEndAction
                            //self.output.mosaicedImages.onNext(myPhotos.data)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                        self.input.loadingEndAction!()
                    }
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        output.myImageCollection
            .subscribe { images in
                var gridColors = [GridColor]()
                GridColor.allCases.forEach { gridColor in
                    images.element?.forEach { image in
                        if image.color == gridColor.rawValue {
                            gridColors.append(gridColor)
                        }
                    }
                }
                self.output.colletedColors.onNext(gridColors.uniqued())
            }
            .disposed(by: disposeBag)
        
    }
}

extension MainViewModel {
    struct Input {
        var loadingEndAction: (()->Void)?
        var userLogin: BehaviorSubject<LoginInfo>
        var willMosaicImage: PublishSubject<UIImage>
        var tapGridColor: PublishSubject<GridColor>
        var addImage: PublishSubject<UIImage>
        var makeMosaicImage: BehaviorSubject<Bool>
    }
    
    struct Output {
        var mosaicedImages: BehaviorSubject<[MosaicImage]>
        var colletedColors: BehaviorSubject<[GridColor]>
        var colorIngredients: BehaviorSubject<[GridColor]>
        var myImageCollection: BehaviorSubject<[Image]>
        var imageForGridColor: BehaviorSubject<[Image]>
    }
}
