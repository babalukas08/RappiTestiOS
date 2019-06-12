//
//  StylableImageView.swift
//  LinioUI
//
//  Created by Danilo Souza on 25/05/17.
//  Copyright © 2017 Linio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

@IBDesignable
public class StylableImageView: UIImageView, ViewStylable {
    
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
    
    @IBInspectable public var styleName: String? {
        didSet {
            styleNameDidSet()
        }
    }
    
    @IBInspectable public var viewShapeName: String? {
        didSet {
            viewShapeNameDidSet()
        }
    }
    
    public var viewCorners: ViewStyle.ViewCorners? = .left {
        didSet {
            resizeCornersBySide()
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
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func applyStyle() {
        applyBasicViewStyle()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        resizeBorderAndMaskLayer()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setNeedsLayout()
    }
    
    public func loadImageWithUrl(_ url: String) {
        // TODO: Remove this, is temporal
        let tempUrl = url.replacingOccurrences(of: ":////", with: "://")
        if tempUrl != "" {
            //addPlaceHolder()
            af_setImage(withURL: URL(string: tempUrl)!, placeholderImage: nil, filter: nil, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25), completion: { (response) -> Void in
                
                if response.result.isSuccess {
                    //self.removePlaceHolder()
                }
            })
        }else {
            self.image = UIImage(named: "no-image")
        }
    }
    
    public func adjustImage() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
}
