//
//  DefaultButton.swift
//  Intercol
//
//  Created by Mauricio Jimenez on 20/11/17.
//  Copyright © 2017 com.MauJimenez. All rights reserved.
//


import UIKit

@IBDesignable
public class DefaultButton: UIButton {
    
    // MARK: ViewStylable properties
    public var borderLayer: CAShapeLayer = CAShapeLayer()
    
    @IBInspectable public var borderWidth: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var viewShapeName: String? {
        didSet {
            viewShapeNameDidSet()
        }
    }
    
    public var viewShape: ViewStyle.ViewShape? = .rect {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var viewStyle: ViewStyle? {
        didSet {
            applyStyle()
        }
    }
    
    @IBInspectable public var cornerRadiusStyle: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public func layout() {
        setNeedsLayout()
    }
    
    public func updateTextTitle(text: String) {
        setTitle(text, for: .normal)
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        
        super.setTitle(title, for: state)
        
        applyStyle()
        
    }
    
    // MARK: Text Stylable Properties
    public var textStyle: TextStyle?
    
    
    // MARK: Button Stylable Properties
    @IBInspectable public var styleName: String? {
        didSet {
            styleNameDidSet()
        }
    }
    
    public var buttonStyle: ButtonStyle? {
        didSet {
            updateSubStylesAccordingToState()
            applyStyle()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    public func setupView() {
        applyStyle()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        resizeBorderAndMaskLayer()
    }
    
    override open var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue
            updateSubStylesAccordingToState()
        }
    }
    
    override public var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = newValue
            updateSubStylesAccordingToState()
        }
    }
    
    public func updateSubStylesAccordingToState() {
        guard let buttonStyle = self.buttonStyle else {
            return
        }
        
        if let primaryViewStyle = buttonStyle.primaryViewStyle,
            let secondaryViewStyle = buttonStyle.secondaryViewStyle {
            if state == .normal {
                viewStyle = primaryViewStyle
            } else {
                viewStyle = secondaryViewStyle
            }
        }
        
        if let primaryTextStyle = buttonStyle.primaryTextStyle,
            let secondaryTextStyle = buttonStyle.secondaryTextStyle {
            
            if self.state == .normal {
                textStyle = primaryTextStyle
            } else {
                textStyle = secondaryTextStyle
            }
        }
        
        applyStyle()
    }
}

extension DefaultButton: ViewStylable, TextStylable {
    public var viewCorners: ViewStyle.ViewCorners? {
        get {return .left}
        set {}
    }
    
    public func styleNameDidSet() {
        // Nil style name; return
        guard let styleName = styleName else {
            return
        }
        
        // Emppty style name; return
        guard styleName.count > 0 else {
            return
        }
        
        // Invalid style name; crash
        guard let styleFromString = ButtonStyleSheet(rawValue: styleName) else {
            assertionFailure("Invalid Style Name sent: \(styleName)")
            return
        }
        
        buttonStyle = styleFromString.getStyle()
    }
    
    public func applyStyle() {
        guard let buttonStyle = self.buttonStyle else {
            return
        }
        
        applyBasicViewStyle()
        titleLabel?.alpha = 1
        applyBasicTextStyle()
        
        
        if let insetLeft = buttonStyle.leftInset,
            let insetRight = buttonStyle.rightInset {
            contentEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(insetLeft), bottom: 0, right: CGFloat(insetRight))
        }
        
        if let buttonHeight = viewStyle?.height {
            let heightConstraint = NSLayoutConstraint(
                item: self,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: CGFloat(buttonHeight))
            
            self.addConstraint(heightConstraint)
        }
    }
    
}

