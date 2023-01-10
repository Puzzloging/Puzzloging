//
//  TabViewController.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/10.
//

import UIKit

class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingViews()
    }

    private func settingViews() {
        tabBar.tintColor = .black

        let mainViewController = MainViewController()
        mainViewController.title = "Main"
        mainViewController.navigationItem.largeTitleDisplayMode = .always
        mainViewController.tabBarItem.image = UIImage(systemName: "house")
        mainViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        let came
        
        setViewControllers([mainViewController], animated: true)

    }
}
