//
//  UIImage+KingFisher.swift
//  TeamMyung
//
//  Created by 이경민 on 2022/12/18.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { result in // 캐시에서 키를 통해 이미지를 가져온다.
            switch result {
            case .success(let value):
                if let image = value.image { // 만약 캐시에 이미지가 존재한다면
                    self.image = image // 바로 이미지를 셋한다.
                } else {
                    guard let url = URL(string: urlString) else { return }
                    let resource = ImageResource(downloadURL: url, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                    self.kf.setImage(with: resource, options: [.transition(.fade(0.5)), .cacheMemoryOnly]) // 이미지를 셋한다.
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
