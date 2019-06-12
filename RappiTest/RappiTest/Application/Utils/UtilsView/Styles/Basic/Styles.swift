//
//  Styles.swift
//  Intercol
//
//  Created by Mauricio Jimenez on 20/11/17.
//  Copyright © 2017 com.MauJimenez. All rights reserved.
//


import UIKit

public struct TextStyle {
    public var color: UIColor?
    public var size: Int?
    public var font: UIFont?
    public var alignment: NSTextAlignment?
    public var strikeThrough: Bool?
    public var underlined: Bool?
    public var lineHeight: CGFloat?
    public var sizeToFitNeed: Bool?
}

public struct ViewStyle {
    public var backgroundColor: UIColor?
    public var borderColor: UIColor?
    public var borderWidth: Int?
    public var shape: ViewShape?
    public var cornerRadiusStyle: Int?
    public var width: Int?
    public var height: Int?
    public var shadow: Bool?
    public var cornersBy: ViewCorners?
    
    public enum ViewShape: String {
        case rect
        case round
    }
    
    public enum ViewCorners: String {
        case left
        case right
    }
}

public struct ButtonStyle {
    public var leftInset: Int?
    public var rightInset: Int?
    
    public var primaryTextStyle: TextStyle?
    public var secondaryTextStyle: TextStyle?
    public var primaryViewStyle: ViewStyle?
    public var secondaryViewStyle: ViewStyle?
}

public struct RatingComponentStyle {
    public var margin: Int?
    public var onImage: UIImage?
    public var offImage: UIImage?
    public var starSize: Int?
    public var primaryColor: UIColor?
}

public struct ShadowStyle {
    public var borderRadius: CGFloat = 0
    public var shadowOffsetStyle: CGSize = CGSize(width: 0, height: 2)
    public var shadowOpacityStyle: CGFloat = 0.2
    public var shadowRadiusStyle: CGFloat = 5
}

public struct FloatLabelStyle {
    public var placeHolderStyle: TextStyle?
    public var textStyle: TextStyle?
    public var floatTextStyle: TextStyle?
    public var clearFieldImage: UIImage?
    public var badFieldImage: UIImage?
    public var goodFieldImage: UIImage?
    public var bottomLineColor: UIColor?
    public var bottomLineHeight: CGFloat?
}

