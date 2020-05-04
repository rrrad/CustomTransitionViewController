//
//  ParentViewController.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 29.04.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    lazy var button: UIButton = {
        let b = UIButton.init(frame: .zero)
        b.setTitle("PRESENT", for: .normal)
        b.addTarget(self, action: #selector(openDidPress), for: .touchUpInside)
        return b
    }()
    
    lazy var button2: UIButton = {
           let b = UIButton.init(frame: .zero)
           b.setTitle("PRESENT2", for: .normal)
           b.addTarget(self, action: #selector(open2DidPress), for: .touchUpInside)
           return b
       }()

    private var child2: UIViewController!
    private var child: UIViewController!
    private var transition: PanelTransition!
    private var transition2: PanelTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        child = ChildViewController()
        transition = PanelTransition.init(presented: child, presenting: self, side: .right)
        
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        
        child2 = DoubleChildViewController()
        transition2 = PanelTransition.init(presented: child2, presenting: self, side: .left)
        
        child2.transitioningDelegate = transition2
        child2.modalPresentationStyle = .custom
        
        view.backgroundColor = .green
        button.frame.size = CGSize.init(width: 100, height: 50)
        button.center = view.center
        
        button2.frame.size = CGSize.init(width: 100, height: 50)
        button2.center = CGPoint.init(x: view.center.x, y: view.center.y - 100)
        
        view.addSubview(button)
        view.addSubview(button2)
    }
    
//    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge { //отключает системный свайп снизу
//        return .bottom
//    }
    
    @objc
    func openDidPress(){
        present(child, animated: true, completion: nil)
    }
    
    @objc
    func open2DidPress(){
        present(child2, animated: true, completion: nil)
    }

}
