//
//  MakeMosaicTableHeaderView.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/13.
//

import UIKit
import SnapKit

class MakeMosaicTableHeaderView: UIView {

    var tapGestureRecognizer = UITapGestureRecognizer()
    var mosaicImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tempImage")
      
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addSubview(mosaicImage)
        mosaicImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
       
    }
}
