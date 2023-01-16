//
//  MakeMosaicFooterView.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/14.
//

import UIKit
import SnapKit

class MakeMosaicTableFooterView: UIView {
    
    let confirmButton: UIView = {
        let button = UIView()
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = .gamLightGray0
        
        return button
    }()
    let textLabel: UILabel = {
        let textLabel = UILabel()
        
        textLabel.text = "모자이크 만들기"
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        confirmButton.addSubview(textLabel)
        
        textLabel.snp.makeConstraints{
            $0.centerY.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(60)
        }
        
        addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(30)
        }
        
    }
}
