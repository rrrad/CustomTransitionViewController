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

    private var child: UIViewController!
    private var transition: PanelTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        child = ChildViewController()
        transition = PanelTransition.init(presented: child, presenting: self)
        
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        
        view.backgroundColor = .green
        button.frame.size = CGSize.init(width: 100, height: 50)
        button.center = view.center
        view.addSubview(button)
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge { //отключает системный свайп снизу
        return .bottom
    }
    
    @objc
    func openDidPress(){
        present(child, animated: true, completion: nil)
    }

}
