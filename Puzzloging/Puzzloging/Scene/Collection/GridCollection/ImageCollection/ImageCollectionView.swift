//
//  ImageCollectionView.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/13.
//

import UIKit
import SnapKit

class imageCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView? = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(imageView ?? UIImageView())
        imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView = nil
    }
    
    
    
}
