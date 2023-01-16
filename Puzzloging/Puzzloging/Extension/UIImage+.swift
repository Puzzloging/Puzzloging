//
//  UIColor+.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/13.
//

import UIKit
import UIImageColors

extension UIImage {
    
    func SplitGrid(times: Int) -> [UIColor] {
        
        var tiles: [UIColor] = []
        let image = self.cgImage
        
        for x in 0..<times {
            for y in 0..<times {
                let tile = image?.cropping(to: CGRect(x: x * (image?.width)!/times, y: y * (image?.height)!/times, width: (image?.width)! / times, height: (image?.height)! / times ))
                tiles.append(UIImage(cgImage: tile!).getColors()!.background)
            }
        }
        
        return tiles.uniqued()
    }

    func getDominantColor(image: UIImage) -> UIColor? {
        return self.getColors()?.background
    }

}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
