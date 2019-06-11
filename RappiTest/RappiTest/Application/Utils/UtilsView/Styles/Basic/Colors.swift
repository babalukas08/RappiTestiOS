//
//  Colors.swift
//  Intercol
//
//  Created by Mauricio Jimenez on 20/11/17.
//  Copyright © 2017 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit

public enum ColorPallete: String {
    
    // Color General
    case white          = "#FFFFFF"
    case black          = "#000000"
    case blackBGAlert   = "414141"
    case redLogin       = "e74d3d"
    case black54        = "363636"
    case hitGray        = "bb9999"
    // Colors by Loft Digital
    case yellowPH       = "ffc417"
    case grayTitle      = "57585b"
    case blackButtons   = "212121"
    case grayBigTitle   = "4a4a4a"
    case graybgView     = "f6f6f6"
    case grayRequest = "D8D8D8"
    case blackTitle = "333333"
    case grayPrice = "666666"
    case grayLayer = "979797"
    case grayFooter = "ededed"
    case bgBaseView = "181027"
    public  func asColor() -> UIColor {
        return hexStringToUIColor(hex: self.rawValue)
    }
    
    public func asColor(withAlpha: CGFloat) -> UIColor {
        let color = self.asColor()
        return color.withAlphaComponent(withAlpha)
    }
    
    private func hexStringToUIColor (hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

// MARK: Gradient Colors
public extension UIColor {
    convenience public  init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

public  typealias GradientType = (x: CGPoint, y: CGPoint)

public enum GradientPoint {
    case leftRight
    case rightLeft
    case topBottom
    case bottomTop
    case topLeftBottomRight
    case bottomRightTopLeft
    case topRightBottomLeft
    case bottomLeftTopRight
    
    public func draw() -> GradientType {
        switch self {
        case .leftRight:
            return (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
        case .rightLeft:
            return (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
        case .topBottom:
            return (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
        case .bottomTop:
            return (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
        case .topLeftBottomRight:
            return (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (x: CGPoint(x: 1, y: 1), y: CGPoint(x: 0, y: 0))
        case .topRightBottomLeft:
            return (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
        case .bottomLeftTopRight:
            return (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
        }
    }
}

public class GradientLayer : CAGradientLayer {
    public var gradient: GradientType? {
        didSet {
            startPoint = gradient?.x ?? CGPoint.zero
            endPoint = gradient?.y ?? CGPoint.zero
        }
    }
}

public class GradientView: UIView {
    override public class var layerClass: Swift.AnyClass {
        get {
            return GradientLayer.self
        }
    }
}

public protocol GradientViewProvider {
    associatedtype GradientViewType
}

public extension GradientViewProvider where Self: UIView, Self.GradientViewType: CAGradientLayer {
    public var gradientLayer: Self.GradientViewType {
        return layer as! Self.GradientViewType
    }
}

extension UIView: GradientViewProvider {
    public typealias GradientViewType = GradientLayer
}

