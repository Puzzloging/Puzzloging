////
////  CustomTabBar.swift
////  Puzzloging
////
////  Created by changgyo seo on 2023/01/10.
////
//
//import UIKit
//import SnapKit
//import RxCocoa
//import RxSwift
//
//class CustomTabBar: UIView {
//    
//    let disposeBag = DisposeBag()
//    var nowType: TabBarItem = .collection
//    var collectionButton: UIButton = {
//        let button = UIButton()
//        
//        button
//    }()
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        backgroundColor = .mainColor
//        layout()
//    }
//    
//    private func layout(){
//        addSubviews(tabBarItems)
//        
//        tabBarItems[0].snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.width.height.equalTo(50)
//            $0.leading.equalToSuperview().inset(15)
//        }
//        tabBarItems[1].snp.makeConstraints {
//            $0.centerY.centerX.equalToSuperview()
//            $0.width.height.equalTo(50)
//
//        }
//        tabBarItems[2].snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.width.height.equalTo(50)
//            $0.trailing.equalToSuperview().inset(15)
//        }
//    }
//}
//
//class CustomTabBarViewController: UIViewController {
//    
//    var customTabBar: CustomTabBar
//    var tabBarItemType: TabBarItem
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(customTabBar)
//        
//        customTabBar.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.height.equalTo(70)
//            $0.leading.trailing.equalToSuperview().inset(20)
//        }
//    }
//    
//    init(tabBarItemType: TabBarItem) {
//        
//        self.tabBarItemType = tabBarItemType
//        self.customTabBar = CustomTabBar()
//        customTabBar.nowType = tabBarItemType
//        
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
