//
//  MainViewModel.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/10.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewModel {
    
    let disposeBag = DisposeBag()
    let dependency: String
    var input: Input
    var output: Output
    

    init(dependency: String) {
        self.dependency = dependency
        
        self.input = Input(tapGridColor: PublishSubject<GridColor>(),
                           addImage: PublishSubject<UIImage>())
        
        self.output = Output(imageForGridColor: PublishSubject<[UIImage]>())
        
        self.input.addImage
            .subscribe { image in
                // add image to db
            }
            .disposed(by: disposeBag)
        
        self.input.tapGridColor
            .
    }
}

extension MainViewModel {
    struct Input {
        var tapGridColor: PublishSubject<GridColor>
        var addImage: PublishSubject<UIImage>
    }
    
    struct Output {
        var imageForGridColor: PublishSubject<[UIImage]>
    }
}
