//
//  RoundedRectTransitionAnimator.swift
//  RoundedRectTransition
//
//  Created by Patrick Duvall on 2018-09-04.
//  Copyright © 2018 Patrick Duvall. All rights reserved.
//

import UIKit

class RoundedRectTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    var senderFrame: CGRect?
    var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return RoundedRectTransitionConstants.presentationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let destinationController = transitionContext.viewController(forKey: .to),
            let destinationView = destinationController.view
        else {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }
        
        let containerView = transitionContext.containerView
        destinationView.frame = containerView.bounds
        destinationView.alpha = 0
        containerView.addSubview(destinationView)
        
        let maskFrame = senderFrame ?? defaultSenderFrame(bounds: fromViewController.view.bounds)
        let maskPath = UIBezierPath(roundedRect: maskFrame, cornerRadius: RoundedRectTransitionConstants.cornerRadius)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = destinationView.frame
        maskLayer.path = maskPath.cgPath
        destinationController.view.layer.mask = maskLayer
        
        // define the end frame and path
        let endFrame = CGRect(origin: CGPoint.zero, size: destinationView.frame.size)
        let endPath = UIBezierPath(roundedRect: endFrame, cornerRadius: RoundedRectTransitionConstants.cornerRadius)
        
        // create the animation
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.delegate = self
        pathAnimation.fromValue = maskPath.cgPath
        pathAnimation.toValue = endPath.cgPath
        pathAnimation.duration = transitionDuration(using: transitionContext)
        maskLayer.path = endPath.cgPath
        maskLayer.add(pathAnimation, forKey: "pathAnimation")
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .beginFromCurrentState, animations: {
            
            destinationView.alpha = 1.0
        }, completion: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if let transitionContext = self.transitionContext {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    fileprivate func defaultSenderFrame(bounds: CGRect) -> CGRect {
        
        // if no sender frame was provided, expand from the center of 'bounds'
        let maskSize = RoundedRectTransitionConstants.defaultMaskSize
        let origin = CGPoint(x: (bounds.width - maskSize.width) / 2, y: (bounds.height - maskSize.height) / 2)
        return CGRect(origin: origin, size: maskSize)
    }
}
