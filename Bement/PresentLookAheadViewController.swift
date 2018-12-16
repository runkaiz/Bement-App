//
//  presentLookAheadViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 11/27/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

class presentLookAheadViewController: NSObject, UIViewControllerAnimatedTransitioning {
    var cellFrame : CGRect!
    var cellTransform : CATransform3D!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let destination = transitionContext.viewController(forKey: .to) as! LookAheadViewController
        let containerView = transitionContext.containerView
        
        containerView.addSubview(destination.view)
        
        let widthConstraint = destination.web.widthAnchor.constraint(equalToConstant: 300)
        let heightConstraint = destination.web.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
        
        let translate = CATransform3DMakeTranslation(cellFrame.origin.x, cellFrame.origin.y, 0.0)
        let transform = CATransform3DConcat(translate, cellTransform)
        
        destination.view.layer.transform = transform
        destination.view.layer.zPosition = 999
        
        containerView.layoutIfNeeded()
        
        let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.7) {
            
            NSLayoutConstraint.deactivate([widthConstraint, heightConstraint])
            
            destination.view.layer.transform = CATransform3DIdentity
            
            containerView.layoutIfNeeded()
        }
        
        animator.addCompletion {
            (finished) in
            
            transitionContext.completeTransition(true)
        }
        
        animator.startAnimation()
    }
}
