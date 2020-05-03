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

    private let transition = PanelTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        button.frame.size = CGSize.init(width: 100, height: 50)
        button.center = view.center
        view.addSubview(button)
    }
    @objc
    func openDidPress(){
        let child = ChildViewController()
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        
        present(child, animated: true, completion: nil)
    }

}
