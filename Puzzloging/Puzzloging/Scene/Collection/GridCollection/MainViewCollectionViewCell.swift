//
//  MainViewCollectionViewCell.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/12.
//

import UIKit
import SnapKit

class MainViewCollectionViewCell: UICollectionViewCell {
    
    var gridColor: GridColor?
    var colorNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
      
        addSubview(colorNameLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = gridColor?.color.withAlphaComponent(0.5)
        colorNameLabel.text = gridColor?.rawValue
        colorNameLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        layer.masksToBounds = true
        layer.cornerRadius = 15
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gridColor = nil
    }
}
