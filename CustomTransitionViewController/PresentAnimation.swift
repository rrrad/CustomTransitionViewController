//
//  PresentAnimation.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 02.05.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit

class PresentAnimation: NSObject {
    let duration: TimeInterval = 0.3
    
    private func animator(using transitionContext: UIViewControllerContextTransitioning ) -> UIViewImplicitlyAnimating {
        let to = transitionContext.view(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)
        to.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        let animator = UIViewPropertyAnimator.init(duration: duration, curve: .easeOut) {
            to.frame = finalFrame
        }
        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        return animator
        
    }
}

extension PresentAnimation: UIViewControllerAnimatedTransitioning {
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
