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

        let viewmodel = MainViewModel(dependency: "changgyo")//{ print($0) } 
        let mainViewController = UINavigationController(rootViewController: MainViewController(viewModel: viewmodel))
        mainViewController.title = "Main"
        mainViewController.navigationItem.largeTitleDisplayMode = .always
        mainViewController.tabBarItem.image = UIImage(systemName: "house")
        mainViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        //mosaic
        
        let makeMosaicViewController = MakeMosaicViewController(viewModel: viewmodel)
        makeMosaicViewController.title = "Mosaic"
        makeMosaicViewController.navigationItem.largeTitleDisplayMode = .always
        makeMosaicViewController.tabBarItem.image = UIImage(systemName: "mosaic")
        makeMosaicViewController.tabBarItem.selectedImage = UIImage(systemName: "mosaic.fill")
        
        let mosaicedImageCollectionViewController = MosaicedImageCollectionViewController(viewmodel: viewmodel)
        mosaicedImageCollectionViewController.title = "MosaicPhotos"
        mosaicedImageCollectionViewController.navigationItem.largeTitleDisplayMode = .always
        mosaicedImageCollectionViewController.tabBarItem.image = UIImage(systemName: "c.circle")
        mosaicedImageCollectionViewController.tabBarItem.selectedImage = UIImage(systemName: "c.circle.fill")
        
        setViewControllers([mainViewController,makeMosaicViewController,mosaicedImageCollectionViewController], animated: true)
    }
}
