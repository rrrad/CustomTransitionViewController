//
//  DismissAnimation.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 02.05.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit

class DismissAnimationRightSide: NSObject {
    let duration: TimeInterval = 0.3
    
    private func animator(using transitionContext: UIViewControllerContextTransitioning ) -> UIViewImplicitlyAnimating {
           let from = transitionContext.view(forKey: .from)!
           let initialFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .from)!)
           let animator = UIViewPropertyAnimator.init(duration: duration, curve: .easeOut) {
            from.frame = initialFrame.offsetBy(dx: initialFrame.width, dy: 0)
           }
           animator.addCompletion { (position) in
               transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
           }
           return animator
       }
    
}

extension DismissAnimationRightSide: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
           return duration
       }
       
       func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
           let animator = self.animator(using: transitionContext)
           animator.startAnimation()
       }
       
       func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
           return self.animator(using: transitionContext)
       }

}
