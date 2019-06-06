//
//  Heading.swift
//  TestStyling
//
//  Created by Danilo Souza on 10/05/17.
//  Copyright © 2017 Danilo Souza. All rights reserved.
//

import UIKit

@IBDesignable
public class Heading: UILabel, TextStylable {
    
    // Stylable protocol
    @IBInspectable public var styleName: String? = "" {
        didSet {
            self.styleNameDidSet()
        }
    }
    
    // TextStylable protocol
    public var textStyle: TextStyle? {
        didSet {
            applyStyle()
        }
    }
    
    override public var text: String? {
        didSet {
            applyStyle()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.adjustsFontSizeToFitWidth = true
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public func setupView() {
        applyStyle()
    }
    
    public func applyStyle() {
        applyBasicTextStyle()
    }
    
    override public func drawText(in rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width,height: CGFloat.greatestFiniteMagnitude),
                                                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                    attributes: [.font: font],
                                                                    context: nil).size
            super.drawText(in: CGRect(x:0,y: 0,width: self.frame.width, height:ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}

extension Heading {
    func getText() -> String {
        return self.text ?? ""
    }
}
