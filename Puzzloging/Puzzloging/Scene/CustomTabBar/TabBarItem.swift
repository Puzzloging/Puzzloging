//
//  TabBarItem.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/10.
//

import UIKit

enum TabBarItem: String, CaseIterable {
    case collection
    case camera
    case mosaic
}

extension TabBarItem {
    
    var viewcontroller: UIViewController {
        switch self {
        case .collection:
            return MainViewController()
        case .camera:
            return UIViewController()
        case .mosaic:
            return UIViewController()
        }
    }
    
    var image: UIImage {
        switch self {
        case .collection:
            return UIImage(systemName: "folder") ?? UIImage()
        case .camera:
            return UIImage(systemName: "camera") ?? UIImage()
        case .mosaic:
            return UIImage(systemName: "mosaic") ?? UIImage()
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .collection:
            return UIImage(systemName: "folder.fill") ?? UIImage()
        case .camera:
            return UIImage(systemName: "camera.fill") ?? UIImage()
        case .mosaic:
            return UIImage(systemName: "mosaic.fill") ?? UIImage()
        }
    }
    
    var name: String {
            return self.rawValue.capitalized
    }
}
