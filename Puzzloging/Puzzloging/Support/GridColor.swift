//
//  GridColor.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/10.
//

import UIKit

enum GridColor: String, CaseIterable {
    
    case black = "Black"
    case red = "Red"
    case white = "White"
    case lime = "Lime"
    case green = "Green"
    case yellow = "Yellow"
    case blue = "Blue"
    case aqua = "Aqua"
    case purple = "Purple"
    case brown = "Brown"
    case gray = "Gray"
    case pink = "Pink"
    case orange = "Orange"
    case navy = "Navy"
    case apricot = "Apricot"
    
    var color: UIColor {
        
        switch self {
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
}
