//
//  GridColor.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/10.
//

import UIKit
import RxSwift

enum GridColor: String, CaseIterable {
    
    case add = "New Picture"
    case mosaic = "Mosaic Picture"
    case black = "black"
    case red = "red"
    case white = "white"
    case lime = "lime"
    case green = "green"
    case yellow = "yellow"
    case blue = "blue"
    case aqua = "aqua"
    case purple = "purple"
    case brown = "brown"
    case gray = "gray"
    case pink = "pink"
    case orange = "orange"
    case navy = "navy"
    case apricot = "apricot"
    
    var color: UIColor {
        
        switch self {
        case .add :
            return .lightGray
        case .mosaic:
            return .lightGray
        case .black:
            return UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
        case .red:
            return UIColor(red: 255 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
        case .white:
            return UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
        case .lime:
            return UIColor(red:  0 / 255, green: 255 / 255, blue: 0 / 255, alpha: 1)
        case .green:
            return UIColor(red: 0 / 255, green: 128 / 255, blue: 0 / 255, alpha: 1)
        case .yellow:
            return UIColor(red: 255 / 255, green: 255 / 255, blue: 0 / 255, alpha: 1)
        case .blue:
            return UIColor(red: 0 / 255, green: 0 / 255, blue: 255 / 255, alpha: 1)
        case .aqua:
            return UIColor(red: 0 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
        case .purple:
            return UIColor(red: 102 / 255, green: 0 / 255, blue: 102 / 255, alpha: 1)
        case .brown:
            return UIColor(red: 102 / 255, green: 51 / 255, blue: 0 / 255, alpha: 1)
        case .gray:
            return UIColor(red: 128 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1)
        case .pink:
            return UIColor(red: 255 / 255, green: 192 / 255, blue: 203 / 255, alpha: 1)
        case .orange:
            return UIColor(red: 155 / 255, green: 165 / 255, blue: 0 / 255, alpha: 1)
        case .navy:
            return UIColor(red: 0 / 255, green: 0 / 255, blue: 128 / 255, alpha: 1)
        case .apricot:
            return UIColor(red: 251 / 255, green: 206 / 255, blue: 177 / 255, alpha: 1)
        }
    }
    
    var koreaColorName: String {
        switch self {
        case .add:
            return "??????"
        case .mosaic:
            return "??????"
        case .black:
            return "?????????"
        case .red:
            return "?????????"
        case .white:
            return "??????"
        case .lime:
            return "?????????"
        case .green:
            return "?????????"
        case .yellow:
            return "?????????"
        case .blue:
            return "?????????"
        case .aqua:
            return "?????????"
        case .purple:
            return "?????????"
        case .brown:
            return "??????"
        case .gray:
            return "??????"
        case .pink:
            return "?????????"
        case .orange:
            return "?????????"
        case .navy:
            return "??????"
        case .apricot:
            return "??????"
        }
    }
    
    static func measureSimilarity(color: UIColor) -> GridColor {
        let components = color.cgColor.components
        var colorDiffValue: CGFloat = 200000.0
        var mostSimilarityColor: GridColor  = .black
        
        GridColor.allCases.forEach { compareColor in
          
            let diffValue = color.difference(from: compareColor.color, using: .CIE94)
            
            switch diffValue {
            case .indentical(let diffValue):
                if colorDiffValue > diffValue {
                    colorDiffValue = diffValue
                    mostSimilarityColor = compareColor
                }
            case .similar(let diffValue):
                if colorDiffValue > diffValue {
                    colorDiffValue = diffValue
                    mostSimilarityColor = compareColor
                }
            case .close(let diffValue):
                if colorDiffValue > diffValue {
                    colorDiffValue = diffValue
                    mostSimilarityColor = compareColor
                }
            case .near(let diffValue):
                if colorDiffValue > diffValue {
                    colorDiffValue = diffValue
                    mostSimilarityColor = compareColor
                }
            case .different(let diffValue):
                if colorDiffValue > diffValue {
                    colorDiffValue = diffValue
                    mostSimilarityColor = compareColor
                }
            case .far(let diffValue):
                if colorDiffValue > diffValue {
                    colorDiffValue = diffValue
                    mostSimilarityColor = compareColor
                }
            }
        }
        return mostSimilarityColor
    }
    
    static func measureSimilarity(colors: [UIColor]) -> Observable<[GridColor]> {
       
        var gridColors = [GridColor]()
     
        for color in colors {
            let components = color.cgColor.components
            var colorDiffValue: CGFloat = 200000.0
            var mostSimilarityColor: GridColor  = .black
            
            GridColor.allCases.forEach { compareColor in
              
                let diffValue = color.difference(from: compareColor.color, using: .CIE94)
                
                switch diffValue {
                case .indentical(let diffValue):
                    if colorDiffValue > diffValue {
                        colorDiffValue = diffValue
                        mostSimilarityColor = compareColor
                    }
                case .similar(let diffValue):
                    if colorDiffValue > diffValue {
                        colorDiffValue = diffValue
                        mostSimilarityColor = compareColor
                    }
                case .close(let diffValue):
                    if colorDiffValue > diffValue {
                        colorDiffValue = diffValue
                        mostSimilarityColor = compareColor
                    }
                case .near(let diffValue):
                    if colorDiffValue > diffValue {
                        colorDiffValue = diffValue
                        mostSimilarityColor = compareColor
                    }
                case .different(let diffValue):
                    if colorDiffValue > diffValue {
                        colorDiffValue = diffValue
                        mostSimilarityColor = compareColor
                    }
                case .far(let diffValue):
                    if colorDiffValue > diffValue {
                        colorDiffValue = diffValue
                        mostSimilarityColor = compareColor
                    }
                }
                
            }
            mostSimilarityColor = mostSimilarityColor == .add ? .gray : mostSimilarityColor
            mostSimilarityColor = mostSimilarityColor == .mosaic ? .gray : mostSimilarityColor
            
            gridColors.append(mostSimilarityColor)
        }
        return Observable.just(gridColors.uniqued())
    }
}
