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
    var sidePanel: SidePanel
    
    init(side: SidePanel) {
        self.sidePanel = side
        super.init()
    }
    
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
        switch sidePanel {
        case .left:
            screenEdgePanRecognizer?.edges = .left // здесь свайп который управляет показом view
        case .right:
            screenEdgePanRecognizer?.edges = .right // здесь свайп который управляет показом view
        }
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
            switch sidePanel {
            case .left:
                update(percentComplete - r.incrementToBottom(maxTranslation: maxTranslation))
            case .right:
                update(percentComplete + r.incrementToBottom(maxTranslation: maxTranslation))
            }
            
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
            switch sidePanel {
            case .left:
                let increment = r.incrementToBottom(maxTranslation: maxTranslation)
                update(percentComplete + increment)
            case .right:
                let increment = -r.incrementToBottom(maxTranslation: maxTranslation)
                update(percentComplete + increment)
            }
                
            
        case .ended, .cancelled:
            if r.isProjectToDownHalf(maxTranslation: maxTranslation) && sidePanel == .left {
                print("FINISH")
                finish()
            } else if !r.isProjectToDownHalf(maxTranslation: maxTranslation) && sidePanel == .right {
                print("FINISH")
                finish()
            } else {
                print("CANCEL")
                cancel()
            }

           case .failed:
               cancel()
           default:
               break
           }
       }
    
    var maxTranslation: CGFloat {
        return presentedController?.view.frame.width ?? 0 // 1.  здесь переключение вертикальной или горизонтальной
    }
    
}

private extension UIPanGestureRecognizer {
    //MARK: - методы расчета для взаимодействию во время закрытия и открытия
    
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).x   // 2.   здесь переключение вертикальной или горизонтальной
        setTranslation(.zero, in: nil)
        
        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
    
    func isProjectToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        print("ENDLOC", endLocation.x, "MAXTRANS", maxTranslation)
        let isPresentationCompleted = endLocation.x > maxTranslation / 2 // 3.   здесь переключение вертикальной или горизонтальной
        print("isPresentationCompleted", isPresentationCompleted)
        return isPresentationCompleted
    }
}
