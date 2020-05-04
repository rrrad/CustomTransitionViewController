//
//  DoubleChildViewController.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 03.05.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit

class DoubleChildViewController: UIViewController {
    
    lazy var button: UIButton = {
           let b = UIButton.init(frame: .zero)
           b.setTitle("DISMIS", for: .normal)
           b.addTarget(self, action: #selector(openDidPress), for: .touchUpInside)
           return b
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 20
        button.frame.size = CGSize.init(width: 100, height: 50)
        button.center = CGPoint.init(x: 200, y: 200)
        view.addSubview(button)
    }
    
    @objc
    func openDidPress(){
        dismiss(animated: true, completion: nil)
    }

}
