//
//  PanelTransition.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 29.04.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    private let driver = TransitionDriver() // подключение класса ответственного за интерактивное взаимодествие
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        driver.link(to: presented) // подключение класса ответственного за интерактивное взаимодествие
        
        let presentationController = DimmPresentationViewController(presentedViewController: presented, presenting: presenting ?? source)
        presentationController.driver = driver // подключение класса ответственного за интерактивное взаимодествие

        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    //MARK: - методы относящиеся к взаимодействию во время закрытия

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
}


