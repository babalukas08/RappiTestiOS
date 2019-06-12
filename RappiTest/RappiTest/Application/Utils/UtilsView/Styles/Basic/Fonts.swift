//
//  Fonts.swift
//  Intercol
//
//  Created by Mauricio Jimenez on 20/11/17.
//  Copyright © 2017 com.MauJimenez. All rights reserved.
//


import Foundation
import UIKit


public enum FontWeight {
    case light
    case base
    case bold
    case semibold
    case medium
}

public enum FontPallete {
    
    case sanFrancisco
    case HelveticaNeue
    case HelveticaB
    case HelveyticaL
    case Helvetica
    case GothamCondensedMedium
    case GothamCondensedBook
    case RobotoLight
    case RobotoRegular
    case RobotoMedium
    
    public func asCustomFont(ofSize: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: setNameFont(TypeFont: self), size: ofSize) else {
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .bold)
        }
        
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledFont(for: customFont)
        } else {
            // Fallback on earlier versions
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .bold)
        }
    }
    
    public func asFont(ofSize: CGFloat) -> UIFont {
        let font = UIFont(name: setNameFont(TypeFont: self), size: CGFloat(ofSize))
        return font!
    }
    
    public func asFont(ofSize: CGFloat, withWeight weight: FontWeight) -> UIFont {
        switch weight {
        case .light:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .light)
        case .base:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .regular)
        case .medium:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .medium)
        case .bold:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .bold)
        case .semibold:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .semibold)
        }
    }
    
    public func setNameFont(TypeFont: FontPallete) -> String {
        switch TypeFont {
        case .sanFrancisco:
            return FontNames.sanFrancisco.rawValue
        case .HelveticaNeue:
            return FontNames.HelveticaNeue.rawValue
        case .HelveticaB:
            return FontNames.HelveticaB.rawValue
        case .HelveyticaL:
            return FontNames.HelveticaL.rawValue
        case .Helvetica:
            return FontNames.Helvetica.rawValue
        case .GothamCondensedMedium:
            return FontNames.GothamCondensedMedium.rawValue
        case .GothamCondensedBook:
            return FontNames.GothamCondensedBook.rawValue
        case .RobotoLight:
            return FontNames.RobotoLight.rawValue
        case .RobotoRegular:
            return FontNames.RobotoRegular.rawValue
        case .RobotoMedium:
            return FontNames.RobotoMedium.rawValue
        }
    }
    
}

public enum FontNames: String {
    case sanFrancisco = "SanFranciscoDisplay-Regular"
    case HelveticaNeue = "HelveticaNeue"
    case HelveticaB = "Helvetica-Bold"
    case HelveticaL = "Helvetica-Light"
    case Helvetica = "Helvetica"
    case GothamCondensedMedium = "GothamCondensed-Medium"
    case GothamCondensedBook = "GothamCondensed-Book"
    case RobotoLight = "Roboto-Light"
    case RobotoRegular = "Roboto-Regular"
    case RobotoMedium = "Roboto-Medium"
    
}
