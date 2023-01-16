//
//  MakeMosaicHeaderTableViewCell.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/13.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class MakeMosaicTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    var viewModel: MainViewModel? = nil
    
    var gridColor: GridColor = .white
    lazy var colorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = gridColor.color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.contentMode = .scaleAspectFit
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 2
        
        return view
    }()
    lazy var colorNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = gridColor.koreaColorName
        
        return label
    }()
    var leftImageCountLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bind()
        addSubviews([colorView, colorNameLabel, leftImageCountLabel])
        
        colorView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(80)
            $0.centerY.equalToSuperview()
        }
        
        colorNameLabel.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(40)
            $0.centerY.equalToSuperview()
        }
        
        leftImageCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    private func bind() {
        viewModel?.output.colletedColors
            .observe(on: MainScheduler.instance)
            .subscribe { list in
                let temp = list.element
                let colors = temp!.uniqued()
                
                var isOkay = false
                colors.forEach { color in
                   
                    if color == self.gridColor {
                        isOkay = true
                    }
                }
                if isOkay {
                    self.backgroundColor = .white
                }
                else {
                    self.backgroundColor = .lightGray
                }
            }
            .disposed(by: disposeBag)
    }
}
