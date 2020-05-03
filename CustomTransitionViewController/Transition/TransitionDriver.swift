//
//  TransitionDriver.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 02.05.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit

enum TransitionDirection {
    case present
    case dismiss
}

class TransitionDriver: UIPercentDrivenInteractiveTransition {
 
    //MARK: - методы относящиеся к взаимодействию для открытия или закрытия контроллеров
    
    private var presentingController: UIViewController? // контроллер для открытия
    private var presentedController: UIViewController? // контроллер для закрытия
    private var panRecognizer: UIPanGestureRecognizer?
    private var screenEdgePanRecognizer: UIScreenEdgePanGestureRecognizer?
    
    func linkPresentationGesture(to controller: UIViewController, presentingController: UIViewController) {
        self.presentedController = controller
        self.presentingController = presentingController
        
        // для интрерактивного закрытия
        panRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panRecognizer!)
        
        // для интерактивного открытия
        screenEdgePanRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(handle(recognizer:)))
        screenEdgePanRecognizer?.edges = .bottom
        presentingController.view.addGestureRecognizer(screenEdgePanRecognizer!)

    }
    
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                let gestureIsActive = screenEdgePanRecognizer?.state == .began
                return gestureIsActive
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }
        
        set { }
    }
    
    var direction: TransitionDirection = .present
    
    @objc private func handle(recognizer r: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognizer: r)
        case .dismiss:
            handleDismiss(recognizer: r)
        }
    }
}
extension TransitionDriver {
    
    //MARK: - методы относящиеся к взаимодействию во время закрытия или открытия

    private func handleDismiss(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
            
            if percentComplete == 0 {
                presentedController?.dismiss(animated: true)
            }
            
        case .changed:
            update(percentComplete + r.incrementToBottom(maxTranslation: maxTranslation))
            
        case .ended, .cancelled:
            if r.isProjectToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }
            
        case .failed:
            cancel()
        default:
            break
        }
    }
    
    private func handlePresentation(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
            
            if percentComplete == 0 {
                presentingController?.present(presentedController!, animated: true)
            }
            
        case .changed:
            let increment = -r.incrementToBottom(maxTranslation: maxTranslation)
            update(percentComplete + increment)
            
        case .ended, .cancelled:
            if r.isProjectToDownHalf(maxTranslation: maxTranslation) {
                cancel()
            } else {
                finish()
            }

           case .failed:
               cancel()
           default:
               break
           }
       }
    
    var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }
    
}

private extension UIPanGestureRecognizer {
    //MARK: - методы относящиеся к взаимодействию во время закрытия
    
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)
        
        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
    
    func isProjectToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        let isPresentationCompleted = endLocation.y > maxTranslation / 2
        
        return isPresentationCompleted
    }
}
