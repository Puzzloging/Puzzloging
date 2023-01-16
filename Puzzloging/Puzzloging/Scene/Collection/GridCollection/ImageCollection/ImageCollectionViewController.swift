//
//  ImageCollectionViewController.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/12.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ImageCollectionViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    
    let viewmodel: MainViewModel
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(imageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        collectionView.delegate = self
        layout()
        bind()
    }
    
    private func layout(){
        view.addSubviews([collectionView])
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func bind(){
        viewmodel.output.imageForGridColor
            .debug()
            .filter { !$0.isEmpty }
            .bind(to: collectionView.rx
                .items(cellIdentifier: "ImageCollectionCell", cellType: imageCollectionViewCell.self)) { indexPath, image, cell in
               
                    let temp = UIImageView()
                    temp.setImage(with: image.imagePath)
                    
                    cell.imageView = temp
                    
            }
            .disposed(by: disposeBag)
    }
    
    init(viewmodel: MainViewModel) {
        self.viewmodel = viewmodel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3 , height: view.frame.width / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
