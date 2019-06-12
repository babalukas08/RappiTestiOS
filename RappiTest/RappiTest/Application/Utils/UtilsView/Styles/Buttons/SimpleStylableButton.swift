//
//  SimpleStylableButton.swift
//  Intercol
//
//  Created by Mauricio Jimenez on 20/11/17.
//  Copyright © 2017 com.MauJimenez. All rights reserved.
//


import UIKit

@IBDesignable
public class SimpleStylableButton: UIButton {
    
    @IBInspectable public var styleName: String? {
        didSet {
            styleNameDidSet()
        }
    }
    
    public var buttonStyle: TextStyle? {
        didSet {
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
    
    public func setupView() {
        
    }
    
    override public func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        applyStyle()
    }
    
}

extension SimpleStylableButton: Stylable {
    
    func styleNameDidSet() {
        // Nil style name; return
        guard let styleName = styleName else {
            return
        }
        
        // Emppty style name; return
        guard styleName.count > 0 else {
            return
        }
        
        // Invalid style name; crash
        guard let styleFromString = TypographyStyle(rawValue: styleName) else {
            assertionFailure("Invalid Style Name sent: \(styleName)")
            return
        }
        
        buttonStyle = styleFromString.getStyle()
    }
    
    func applyStyle() {
        guard let buttonStyle = self.buttonStyle else {
            return
        }
        
        
        var highlightColor = buttonStyle.color
        if let buttonColor = buttonStyle.color {
            highlightColor = generateHighlightColor(buttonColor)
        }
        
        setTitleColor(buttonStyle.color, for: .normal)
        setTitleColor(highlightColor, for: .focused)
        setTitleColor(highlightColor, for: .highlighted)
        setTitleColor(highlightColor, for: .selected)
        titleLabel?.font = buttonStyle.font
        
        if buttonStyle.underlined == true || buttonStyle.strikeThrough == true {
            setAttributedTitle(createAttributedStringForState(.normal), for: .normal)
            setAttributedTitle(createAttributedStringForState(.focused), for: .focused)
            setAttributedTitle(createAttributedStringForState(.highlighted), for: .highlighted)
            setAttributedTitle(createAttributedStringForState(.selected), for: .selected)
        }
    }
    
    func createAttributedStringForState(_ state: UIControl.State) -> NSAttributedString? {
        
        guard let buttonStyle = self.buttonStyle else {
            return nil
        }
        
        let text = title(for: state) ?? ""
        var attributedText = attributedTitle(for: state) ?? NSMutableAttributedString(string: text)
        
        
        if buttonStyle.strikeThrough == true {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
            
            attributeString.addAttribute(
                .strikethroughStyle,
                value: 2,
                range: NSMakeRange(0, attributeString.length))
            
            attributedText = attributeString
        }
        
        if buttonStyle.underlined == true {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
            
            attributeString.addAttribute(
                .underlineStyle,
                value: 1,
                range: NSMakeRange(0, attributeString.length))
            
            attributedText = attributeString
        }
        
        if state != .normal,
            let buttonColor = buttonStyle.color {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
            
            attributeString.addAttribute(
                .foregroundColor,
                value: generateHighlightColor(buttonColor),
                range: NSMakeRange(0, attributeString.length))
            
            attributedText = attributeString
        }
        
        return attributedText
    }
    
    func generateHighlightColor(_ color: UIColor) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if color.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            var targetBrightness = b * 1.3
            if b < 0.9 {
                targetBrightness = b * 0.7
            }
            let highlightColor = UIColor(hue: h, saturation: s, brightness: targetBrightness, alpha: a)
            return highlightColor
        }
        
        return color
    }
    
}

