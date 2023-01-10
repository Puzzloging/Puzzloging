//
//  UIViewController+Rxswift.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/10.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    
    func keyboardHeight() -> Observable<CGFloat> {
        let keyboardWillShowObserver = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0 }
        
        let keyboardwillHideObserver =  NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { -1 * (($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0) }
        
        return Observable
                .from([ keyboardWillShowObserver, keyboardwillHideObserver ])
                .merge()
    }
}
