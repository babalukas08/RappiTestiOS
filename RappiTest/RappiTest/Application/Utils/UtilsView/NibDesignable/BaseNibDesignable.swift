//
//  BaseNibDesignable.swift
//  PalacioJuguetes
//
//  Created by Mauricio Jimenez on 03/09/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol BaseViewNibDesignableDelegate : class {
    func reloadSectionbyId(idSectionItem: String, indexSection: Int)
}

extension BaseViewNibDesignableDelegate {
    func reloadSectionbyId(idSectionItem: String, indexSection: Int) {}
}

public class BaseViewNibDesignable: NibDesignable {
    
    weak  var delegateBase: BaseViewNibDesignableDelegate?
    var viewDisabled : UIView = UIView()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Config View
    func setupView() {
        
    }
    
    func configure<T>(model: T) {
        
    }
    
    // only for Section function
    func configure<T>(model: T, closure: @escaping (Bool) -> Void) {
        
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 0)
    }
    
    func showViewDisabled(show: Bool) {
        
        if show {
            viewDisabled.backgroundColor = ColorPallete.blackBGAlert.asColor(withAlpha: 0.60)
            self.addSubview(viewDisabled)
            
            viewDisabled.translatesAutoresizingMaskIntoConstraints = false
            viewDisabled.widthAnchor.constraint(equalTo: self.widthAnchor, constant:0).isActive = true
            viewDisabled.heightAnchor.constraint(equalTo: self.heightAnchor, constant:0).isActive = true
            viewDisabled.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:0).isActive = true
            viewDisabled.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:0).isActive = true
            viewDisabled.clipsToBounds = true
        }
        else {
            viewDisabled.removeFromSuperview()
        }
        
    }
}
