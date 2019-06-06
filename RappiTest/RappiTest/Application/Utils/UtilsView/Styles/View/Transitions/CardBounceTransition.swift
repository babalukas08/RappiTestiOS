//
//  CardBounceTransition.swift
//  Linio
//
//  Created by Danilo Souza on 19/07/17.
//  Copyright © 2017 Linio. All rights reserved.
//

import UIKit

public protocol CardBounceableController: class {
    var animatingIn: Bool { get set }
    var cardBounceTransitionBg: UIView? { get }
    var cardBounceTransitionCardView: UIView? { get }
    var cardBounceableTransition: CardBounceableControllerTransition? { get set }
}

public class CardBounceableControllerTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    weak public var targetCardBounceableController: CardBounceableController?
    
    public init(targetCardBounceableController: CardBounceableController) {
        self.targetCardBounceableController = targetCardBounceableController
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        targetCardBounceableController?.animatingIn = true
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        targetCardBounceableController?.animatingIn = false
        return self
    }
    
}

extension CardBounceableControllerTransition: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if targetCardBounceableController?.animatingIn == true{
            animateIn(using: transitionContext)
        } else {
            animateOut(using: transitionContext)
        }
    }
    
    // Enter animation
    func animateIn(using transitionContext: UIViewControllerContextTransitioning) {
        //        let vc1 = transitionContext.viewController(forKey:.from)!
        let vc2 = transitionContext.viewController(forKey:.to)!
        let con = transitionContext.containerView
        //        let r1start = transitionContext.initialFrame(for:vc1)
        let r2end = transitionContext.finalFrame(for:vc2)
        //        let v1 = transitionContext.view(forKey:.from)!
        let v2 = transitionContext.view(forKey:.to)!
        
        con.addSubview(v2)
        
        let duration = transitionDuration(using: transitionContext)
        v2.frame = r2end
        
        guard let alertController = vc2 as? CardBounceableController else {
            transitionContext.completeTransition(true)
            return
        }
        
        alertController.cardBounceTransitionBg?.alpha = 0
        
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                alertController.cardBounceTransitionBg?.alpha = 1
        }) { _ in
            
        }
        
        alertController.cardBounceTransitionCardView?.transform = CGAffineTransform(translationX: 0, y: v2.frame.height)
        UIView.animate(
            withDuration: duration,
            delay: 0.1,
            usingSpringWithDamping: 0.77,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                alertController.cardBounceTransitionCardView?.transform = CGAffineTransform.identity
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    // Exit animation
    func animateOut(using transitionContext: UIViewControllerContextTransitioning) {
        let vc1 = transitionContext.viewController(forKey:.from)!
        let con = transitionContext.containerView
        let r1start = transitionContext.initialFrame(for:vc1)
        let v1 = transitionContext.view(forKey:.from)!
        
        con.addSubview(v1)
        
        let duration = transitionDuration(using: transitionContext)
        v1.frame = r1start
        
        guard let alertController = vc1 as? CardBounceableController else {
            transitionContext.completeTransition(true)
            return
        }
        
        UIView.animate(
            withDuration: 0.35,
            delay: 0.1,
            options: .curveEaseInOut,
            animations: {
                alertController.cardBounceTransitionBg?.alpha = 0.0
        }) { _ in
            
        }
        
        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            usingSpringWithDamping: 3,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                alertController.cardBounceTransitionCardView?.transform = CGAffineTransform(translationX: 0, y: v1.frame.height)
        }) { _ in
            transitionContext.completeTransition(true)
        }
        
    }
    
}

