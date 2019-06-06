//
//  StylableShadowView.swift
//  LinioUIKit
//
//  Created by Danilo Souza on 10/08/17.
//  Copyright © 2017 Linio. All rights reserved.
//

import UIKit

@IBDesignable
public class StylableShadowView: UIView, ShadowStylable {
    
    public var viewShape: ViewStyle.ViewShape?
    
    
    public var borderLayer: CAShapeLayer = CAShapeLayer()
    
    @IBInspectable public var borderWidth: Int = 0 {
        didSet {
            self.layer.borderWidth = CGFloat(borderWidth)
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var cornerRadiusStyle: Int = 0 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadiusStyle)
            setNeedsLayout()
        }
    }
    
    public var viewCorners: ViewStyle.ViewCorners? = .left {
        didSet {
            resizeCornersBySide()
        }
    }
    
    @IBInspectable public var styleName: String? {
        didSet {
            styleNameDidSet()
        }
    }
    
    public var shadowStyle: ShadowStyle? {
        didSet {
            applyStyle()
        }
    }
    
    @IBInspectable public var borderRadius: CGFloat = 0 {
        didSet {
            self.setupShadow()
        }
    }
    
    @IBInspectable public var shadowOffsetStyle: CGSize = CGSize(width: 0, height: 2) {
        didSet {
            self.setupShadow()
        }
    }
    
    @IBInspectable public var shadowOpacityStyle: CGFloat = 0.2 {
        didSet {
            self.setupShadow()
        }
    }
    
    @IBInspectable public var shadowRadiusStyle: CGFloat = 5 {
        didSet {
            self.setupShadow()
        }
    }
    
    public override var bounds: CGRect {
        didSet {
            self.setupShadow()
        }
    }
    
    @IBInspectable public var viewShapeName: String? {
        didSet {
            viewShapeNameDidSet()
        }
    }
    
    @IBInspectable public var backColor: UIColor? = ColorPallete.white.asColor() {
        didSet {
            backgroundColor = backColor
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        setupShadow()
    }
    
    func applyStyle() {
        if let shadowStyle = self.shadowStyle {
            self.borderRadius = shadowStyle.borderRadius
            self.shadowOffsetStyle = shadowStyle.shadowOffsetStyle
            self.shadowOpacityStyle = shadowStyle.shadowOpacityStyle
            self.shadowRadiusStyle = shadowStyle.shadowRadiusStyle
        }
        
        setupShadow()
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = self.borderRadius
        self.layer.shadowOffset = self.shadowOffsetStyle
        self.layer.shadowRadius = self.shadowRadiusStyle
        self.layer.shadowOpacity = Float(self.shadowOpacityStyle)
        self.layer.shadowPath = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(
                width: self.borderRadius,
                height: self.borderRadius)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
}


