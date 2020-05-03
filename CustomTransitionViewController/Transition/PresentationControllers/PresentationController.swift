//
//  PresentationController.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 29.04.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let halfWidth = bounds.width - 50
        return CGRect.init(x: 50,
                           y: containerView?.safeAreaInsets.top ?? 0,
                           width: halfWidth,
                           height: bounds.height)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView!.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    //MARK: - методы относящиеся к взаимодействию во время закрытия и открытия
    
    var driver: TransitionDriver!
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if completed {
            driver.direction = .dismiss
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            driver.direction = .present
        }
    }
}
