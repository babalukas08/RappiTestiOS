//
//  AlertViewController.swift
//  Apps Mauricio Jimenez
//
//  Created by Mauricio Jimenez on 29/05/17.
//  Copyright © 2017 AlgoBonito. All rights reserved.
//

import UIKit

public protocol AlertHostControllerDelegate: class {
    func onTapCancelHost()
}

public protocol AlertController {
    
    func showFilterModal(delegate: FilterViewDelegate, model: [BaseGenerModel]) -> FilterView
}

public extension AlertController where Self: UIViewController {
    
    //AlertAboutView
    @discardableResult func showFilterModal(delegate: FilterViewDelegate, model: [BaseGenerModel]) -> FilterView {
        let modal = FilterView()
        modal.delegate = delegate
        modal.configure(model: model)
        modal.translatesAutoresizingMaskIntoConstraints = false
        
        let hostViewController = AlertHostController()
        hostViewController.isEnabledTapBackground = true
        hostViewController.view.addSubview(modal)
        hostViewController.delegate = modal
        
        setConstraints(alert: modal, containerView: hostViewController.view)
        
        self.present(hostViewController, animated: true, completion: nil)
        
        return modal

    }
    
    // FilterView
    func setConstraints(alert: UIView, containerView: UIView, size: CGSize? = nil, isTop: Bool? = nil) {
        
        let width : CGFloat = size != nil ? size!.width : Constants.devicesWidth.widthDevice - 44
        let height: CGFloat = size != nil ? size!.height : 450
        
        
        let widthConstraint = NSLayoutConstraint(
            item: alert,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: width)
        
        let heightConstraint = NSLayoutConstraint(
            item: alert,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: height)
        
        let centerConstraintX = NSLayoutConstraint(
            item: alert,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)
        
        let centerConstraintY = NSLayoutConstraint(
            item: alert,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0)
        
        let centerConstraintTop = NSLayoutConstraint(
            item: alert,
            attribute: .top,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .top,
            multiplier: 1,
            constant: 152)
        
        alert.addConstraint(widthConstraint)
        alert.addConstraint(heightConstraint)
        
        if let top = isTop {
            if !top {
                containerView.addConstraints([centerConstraintX, centerConstraintY])
            }
            else {
                containerView.addConstraints([centerConstraintX, centerConstraintTop])
                
            }
        }
        else {
            containerView.addConstraints([centerConstraintX, centerConstraintY])
        }
    }
    
    func setConstraintsForAlert(alert: UIView, containerView: UIView, size: CGSize? = nil, isTop: Bool? = nil) {
        
        let width : CGFloat = size != nil ? size!.width : Constants.devicesWidth.widthDevice - 44
        let height: CGFloat = size != nil ? size!.height : 350
        
        
        let widthConstraint = NSLayoutConstraint(
            item: alert,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: width)
        
        let heightConstraint = NSLayoutConstraint(
            item: alert,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: height)
        
        let centerConstraintX = NSLayoutConstraint(
            item: alert,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)
        
        let centerConstraintY = NSLayoutConstraint(
            item: alert,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0)
        
        let centerConstraintTop = NSLayoutConstraint(
            item: alert,
            attribute: .top,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .top,
            multiplier: 1,
            constant: 152)
        
        alert.addConstraint(widthConstraint)
        alert.addConstraint(heightConstraint)
        
        if let top = isTop {
            if !top {
                containerView.addConstraints([centerConstraintX, centerConstraintY])
            }
            else {
                containerView.addConstraints([centerConstraintX, centerConstraintTop])

            }
        }
        else {
            containerView.addConstraints([centerConstraintX, centerConstraintY])
        }
    }
    
}

class AlertHostController: UIViewController {
    
    var isEnabledTapBackground = false
    weak public var delegate: AlertHostControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = UIView()
        backgroundView.frame = self.view.bounds
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(backgroundView)
        
        self.view.backgroundColor = ColorPallete.black.asColor(withAlpha: 0.8)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapBackground))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc func onTapBackground() {
        if isEnabledTapBackground {
            self.delegate?.onTapCancelHost()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
