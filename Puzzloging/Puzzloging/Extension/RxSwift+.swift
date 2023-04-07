//
//  RxSwift+.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/14.
//

import UIKit
import RxSwift
import RxCocoa

extension RxSwift.Reactive where Base: UIViewController {
    
    public var viewWillAppear: Observable<Bool> {
    return methodInvoked(#selector(UIViewController.viewWillAppear))
       .map { $0.first as? Bool ?? false }
  }
}
