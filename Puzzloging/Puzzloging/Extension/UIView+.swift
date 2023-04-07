//
//  UIView+.swift
//  TeamMyung
//
//  Created by 이경민 on 2022/12/18.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    func isKeyBoard(at keyboardHeight: CGFloat) {
        self.frame.origin.y -= keyboardHeight
    }
}
