//
//  PresentationController.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 29.04.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    var sidePanel: SidePanel = .left
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var rect = CGRect.init(x: 0, y: 0, width: 0, height: 0)
        
        if sidePanel == .right {
            let bounds = containerView!.bounds
            let halfWidth = bounds.width - 50
            rect = CGRect.init(x: 50,
                               y: containerView?.safeAreaInsets.top ?? 0,
                               width: halfWidth,
                               height: bounds.height)
        } else if sidePanel == .left {
            let bounds = containerView!.bounds
            let halfWidth = bounds.width - 50
            rect = CGRect.init(x: 0,
                               y: containerView?.safeAreaInsets.top ?? 0,
                               width: halfWidth,
                               height: bounds.height)
        }
        return rect
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
