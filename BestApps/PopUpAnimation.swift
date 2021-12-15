//
//  PopUpAnimation.swift
//  BestApps
//
//  Created by Andrés Guzmán on 13/12/21.
//  Copyright © 2021 andres. All rights reserved.
//

import UIKit

protocol AnimationCompletionDelegate: AnyObject {
    func dismissCompleted()
}

final class PopUpAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.3
    var presenting = true
    var originFrame = CGRect.zero
    weak var animationDelegate: AnimationCompletionDelegate?
    var snapshot: UIImage?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        guard let targetView = presenting ? toView : fromView else { return }
        let initialFrame = presenting ? originFrame : targetView.frame
        let finalFrame = presenting ? targetView.frame : originFrame
        
        let xScaleFactor = presenting ?
        initialFrame.width / finalFrame.width :
        finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
        initialFrame.height / finalFrame.height :
        finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            targetView.transform = scaleTransform
            targetView.center = CGPoint(x: initialFrame.midX,
                                        y: initialFrame.midY)
            targetView.clipsToBounds = true
        }
        
        targetView.layer.cornerRadius = presenting ? 8.0 : 0.0
        targetView.layer.masksToBounds = true
        
        if let toView = toView {
            containerView.addSubview(toView)
        }
        
        containerView.bringSubviewToFront(targetView)
        
        UIView.animate(
            withDuration: duration,
            delay: .zero,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.5,
            animations: {
                if !self.presenting {
                    let imageView = UIImageView(frame: transitionContext.containerView.bounds)
                    imageView.image = self.snapshot
                    targetView.addSubview(imageView)
                }
                
                targetView.transform = self.presenting ? .identity : scaleTransform
                targetView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                targetView.layer.cornerRadius = !self.presenting ? 8.0 : 0.0
            }, completion: { _ in
                if !self.presenting {
                    self.animationDelegate?.dismissCompleted()
                }
                transitionContext.completeTransition(true)
            })
    }
}
