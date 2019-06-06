//
//  StylableTextView.swift
//  LinioUI
//
//  Created by Danilo Souza on 03/07/17.
//  Copyright © 2017 Linio. All rights reserved.
//

import UIKit

@IBDesignable
public class StylableTextView: UITextView, TextStylable {
    
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
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
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

    
}
