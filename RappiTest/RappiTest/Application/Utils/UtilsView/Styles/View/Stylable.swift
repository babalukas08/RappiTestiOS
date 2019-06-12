//
//  Stylable.swift
//  TestStyling
//
//  Created by Danilo Souza on 10/05/17.
//  Copyright © 2017 Danilo Souza. All rights reserved.
//

import UIKit

protocol Stylable: class {
    var styleName: String? { get set }
    func applyStyle()
}


protocol TextStylable: Stylable {
    var textStyle: TextStyle? { get set }
    
    func getTextForStyling() -> String?
    func getAttributedTextForStyling() -> NSAttributedString?
    func setStyledAttributedText(styledAttributedString: NSAttributedString?)
    func getComponentAlignment() -> NSTextAlignment?
    func attributedStringFromHtmlString(htmlString: String) -> NSAttributedString?
    func getParagraphLineBreakStyle() -> NSLineBreakMode?
}

extension TextStylable {
    
    func attributedStringFromHtmlString(htmlString: String) -> NSAttributedString? {
        guard let data = htmlString.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil
        }
        
        return try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
    }
    
    func getParagraphLineBreakStyle() -> NSLineBreakMode? {
        return nil//NSLineBreakMode.byTruncatingTail
    }
    
}

extension TextStylable where Self: UILabel {
    
    func getTextForStyling() -> String? {
        return self.text
    }
    
    func getAttributedTextForStyling() -> NSAttributedString? {
        return self.attributedText
    }
    
    func setStyledAttributedText(styledAttributedString: NSAttributedString?) {
        self.attributedText = styledAttributedString
    }
    
    func getComponentAlignment() -> NSTextAlignment? {
        return self.textAlignment
    }
    
}

extension TextStylable where Self: UITextField {
    
    func getTextForStyling() -> String? {
        return self.text
    }
    
    func getAttributedTextForStyling() -> NSAttributedString? {
        return self.attributedText
    }
    
    func setStyledAttributedText(styledAttributedString: NSAttributedString?) {
        self.attributedText = styledAttributedString
    }
    
    func getComponentAlignment() -> NSTextAlignment? {
        return self.textAlignment
    }
    
}

extension TextStylable where Self: UITextView {
    
    func getTextForStyling() -> String? {
        return self.text
    }
    
    func getAttributedTextForStyling() -> NSAttributedString? {
        return self.attributedText
    }
    
    func setStyledAttributedText(styledAttributedString: NSAttributedString?) {
        self.attributedText = styledAttributedString
    }
    
    func getComponentAlignment() -> NSTextAlignment? {
        return self.textAlignment
    }
    
    func getParagraphLineBreakStyle() -> NSLineBreakMode? {
        return nil
    }
    
}

extension TextStylable where Self: UIButton {
    
    func getTextForStyling() -> String? {
        return title(for: self.state)
    }
    
    func getAttributedTextForStyling() -> NSAttributedString? {
        return self.attributedTitle(for: self.state)
    }
    
    func setStyledAttributedText(styledAttributedString: NSAttributedString?) {
        self.setAttributedTitle(styledAttributedString, for: self.state)
    }
    
    func getComponentAlignment() -> NSTextAlignment? {
        return self.titleLabel?.textAlignment
    }
    
}


extension TextStylable where Self: UIView {
    
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
        
        textStyle = styleFromString.getStyle()
        applyStyle()
    }
    
    func applyBasicTextStyle() {
        guard let textStyle = self.textStyle else {
            return
        }
        
        if let text = getTextForStyling() {
            let styledAttributedString = attributedStringWithStyle(string: text, style: textStyle)
            setStyledAttributedText(styledAttributedString: styledAttributedString)
        } else if let attributedText = getAttributedTextForStyling() {
            let styledAttributedString = applyStyleToAttributedString(attributedString: attributedText, style: textStyle)
            setStyledAttributedText(styledAttributedString: styledAttributedString)
        }
        setNeedsLayout()
    }
    
    func attributedStringWithStyle(string: String?, style: TextStyle) -> NSAttributedString? {
        
        let textToStyle = string ?? ""
        let styledString = NSMutableAttributedString(string: textToStyle)
        return applyStyleToAttributedString(attributedString: styledString, style: style)
    }
    
    func applyStyleToAttributedString(attributedString: NSAttributedString, style: TextStyle) -> NSAttributedString? {
        guard var styledString = attributedString.mutableCopy() as? NSMutableAttributedString else {
            return attributedString
        }
        
        if let styleFont = style.font {
            let attributeString = styledString
            attributeString.addAttribute(.font, value: styleFont, range: NSMakeRange(0, attributeString.length))
            styledString = attributeString
        }
        
        if let styleFontColor = style.color {
            let attributeString = styledString
            attributeString.addAttribute(.foregroundColor, value: styleFontColor, range: NSMakeRange(0, attributeString.length))
            styledString = attributeString
        }
        
        if style.strikeThrough == true {
            let attributeString = styledString
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            styledString = attributeString
        }
        
        if style.underlined == true {
            let attributeString = styledString
            attributeString.addAttribute(.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            styledString = attributeString
        }
        
        //        if let sizeFit = style.sizeToFitNeed, sizeFit {
        //            let attributeString = styledString
        //        }
        
        if let lineHeight = style.lineHeight {
            let attributeString = styledString
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight
            
            if let paragraphLineBreakStyle = self.getParagraphLineBreakStyle() {
                paragraphStyle.lineBreakMode = paragraphLineBreakStyle
            }
            
            if let alignment = self.getComponentAlignment() {
                paragraphStyle.alignment = alignment
            }
            attributeString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
            styledString = attributeString
        }
        
        return styledString
    }
    
}


protocol ViewStylable: Stylable, RoundRect {
    var viewStyle: ViewStyle? { get set }
}

extension ViewStylable where Self: UIView {
    
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
        guard let styleFromString = ViewStyleSheet(rawValue:  styleName) else {
            assertionFailure("Invalid Style Name sent: \(styleName)")
            return
        }
        
        viewStyle = styleFromString.getStyle()
        applyStyle()
    }
    
    func applyBasicViewStyle() {
        guard let viewStyle = self.viewStyle else {
            return
        }
        
        if let viewShape = viewStyle.shape {
            self.viewShape = viewShape
        }
        
        if let corners = viewStyle.cornersBy {
            self.viewCorners = corners
        }
        
        if let cornerRadius = viewStyle.cornerRadiusStyle {
            self.cornerRadiusStyle = cornerRadius
        }
        
        if let borderWidth = viewStyle.borderWidth,
            let borderColor = viewStyle.borderColor {
            
            self.borderWidth = borderWidth
            self.borderColor = borderColor
        }
        
        if let bgColor = viewStyle.backgroundColor {
            backgroundColor = bgColor
        }
        
        if let shadow = viewStyle.shadow {
            if shadow {
                self.layer.masksToBounds = true
                self.layer.shadowColor = ColorPallete.blackBGAlert.asColor().cgColor
                self.layer.shadowOpacity = 0.5
                self.layer.shadowOffset = CGSize.zero
                self.layer.shadowRadius = 1
                self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
                self.layer.shouldRasterize = true
                self.layer.rasterizationScale = shadow ? UIScreen.main.scale : 1
            }
        }
        
        applyCorners()
    }
    
}

protocol ShadowStylable: Stylable, RoundRect {
    var shadowStyle: ShadowStyle? { get set }
}

extension ShadowStylable where Self: UIView {
    
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
        guard let styleFromString = ShadowViewStyleSheet(rawValue: styleName) else {
            assertionFailure("Invalid Style Name sent: \(styleName)")
            return
        }
        
        shadowStyle = styleFromString.getStyle()
        applyStyle()
    }
    
}

