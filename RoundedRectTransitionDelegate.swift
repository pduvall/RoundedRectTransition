//
//  RoundedRectTransitionDelegate.swift
//  RoundedRectTransition
//
//  Created by Patrick Duvall on 2018-09-04.
//  Copyright © 2018 Patrick Duvall. All rights reserved.
//

import UIKit

class RoundedRectTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    var senderFrame: CGRect?
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = RoundedRectTransitionAnimator()
        animator.senderFrame = senderFrame
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = RoundedRectTransitionAnimatorDismiss()
        animator.senderFrame = senderFrame
        return animator
    }
}
