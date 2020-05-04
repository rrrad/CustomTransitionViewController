//
//  PanelTransition.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 29.04.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit

enum SidePanel{
    case left
    case right
}

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    private var sidePanel: SidePanel
    private let driver: TransitionDriver
    
    init(presented: UIViewController, presenting: UIViewController, side: SidePanel) {
        self.sidePanel = side
        driver = TransitionDriver(side: side) // подключение класса ответственного за интерактивное взаимодествие
        driver.linkPresentationGesture(to: presented, presentingController: presenting) // подключение жестов
    }
    
     
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = DimmPresentationViewController(presentedViewController: presented, presenting: presenting ?? source)
        presentationController.driver = driver // подключение класса ответственного за интерактивное взаимодествие
        presentationController.sidePanel = sidePanel
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch sidePanel{
        case .right:
            return PresentAnimationRightSide()
        case .left:
            return PresentAnimationLeftSide()
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch sidePanel{
        case .right:
            return DismissAnimationRightSide()
        case .left:
            return DismissAnimationLeftSide()
        }
        
    }
    //MARK: - методы относящиеся к взаимодействию во время закрытия

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
}


