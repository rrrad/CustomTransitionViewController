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
        let halfHeight = bounds.height / 2
        return CGRect.init(x: 0,
                           y: halfHeight,
                           width: bounds.width,
                           height: halfHeight)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView!.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    //MARK: - методы относящиеся к взаимодействию во время закрытия
    
    var driver: TransitionDriver!
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if completed {
            driver.direction = .dismiss
        }
    }
}
