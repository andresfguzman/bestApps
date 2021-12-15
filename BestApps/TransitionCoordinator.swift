//
//  TransitionCoordinator.swift
//  BestApps
//
//  Created by Andrés Guzmán on 14/12/21.
//  Copyright © 2021 andres. All rights reserved.
//

import UIKit

final class TransitionCoordinator: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircularTransition()
    }
    
}

final class CircularTransition: NSObject, UIViewControllerAnimatedTransitioning {
    weak var context: UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? CircleTransitionable,
              let toVC = transitionContext.viewController(forKey: .to) as? CircleTransitionable,
              let snapshot = fromVC.mainView.snapshotView(afterScreenUpdates: false) else {
                  transitionContext.completeTransition(false)
                  return
              }
        context = transitionContext
        let containerView = transitionContext.containerView
        
        let backgroundView = UIView()
        backgroundView.frame = toVC.mainView.frame
        backgroundView.backgroundColor = fromVC.mainView.backgroundColor
        containerView.addSubview(backgroundView)
        containerView.addSubview(snapshot)
        
        fromVC.mainView.removeFromSuperview()
        animateOldTextOffscreen(fromView: snapshot)
        containerView.addSubview(toVC.mainView)
        animate(toView: toVC.mainView, fromTriggerView: fromVC.triggerView)
        animateToTextView(toCosmeticView: toVC.cosmeticView, fromTriggerView: fromVC.triggerView)

    }
    
    func animateOldTextOffscreen(fromView: UIView) {
        // 1
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: [.curveEaseIn],
                       animations: {
            // 2
            fromView.center = CGPoint(x: fromView.center.x,
                                      y: UIScreen.main.bounds.height * 1.5)
            // 3
            fromView.transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
        }, completion: nil)
    }
    
    func animate(toView: UIView, fromTriggerView triggerView: UIView) {
        // 1
        let rect = CGRect(x: triggerView.frame.origin.x,
                          y: triggerView.frame.origin.y  + 230,
                          width: triggerView.frame.width,
                          height: triggerView.frame.width)
        // 2
        let circleMaskPathInitial = UIBezierPath(ovalIn: rect)
        // 1
        let fullHeight = toView.bounds.height + 100
        let extremePoint = CGPoint(x: triggerView.center.x,
                                   y: triggerView.center.y - fullHeight)
        // 2
        let radius = sqrt((extremePoint.x*extremePoint.x) +
                          (extremePoint.y*extremePoint.y))
        // 3
        let circleMaskPathFinal = UIBezierPath(ovalIn: triggerView.frame.insetBy(dx: -radius,
                                                                                   dy: -radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        toView.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = 0.25
        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    func animateToTextView(toCosmeticView: UIView, fromTriggerView: UIView) {
        let originalCenter = toCosmeticView.center
        toCosmeticView.alpha = .zero
        toCosmeticView.center = CGPoint(x: fromTriggerView.center.x, y: fromTriggerView.center.y - 260)
        toCosmeticView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.25, delay: 0.1, options: [.curveEaseOut], animations: {
            toCosmeticView.transform = .identity
            toCosmeticView.center = originalCenter
            toCosmeticView.alpha = 1.0
        }, completion: nil)
    }
}

extension CircularTransition: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        context?.completeTransition(true)
    }
}


protocol CircleTransitionable {
    var triggerView: UIView { get }
    var cosmeticView: UIView { get }
    var mainView: UIView { get }
}
