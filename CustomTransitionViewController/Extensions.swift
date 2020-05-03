//
//  Extensions.swift
//  CustomTransitionViewController
//
//  Created by Radislav Gaynanov on 02.05.2020.
//  Copyright © 2020 Radislav Gaynanov. All rights reserved.
//

import UIKit


extension UIPanGestureRecognizer {
   //MARK: - методы относящиеся к взаимодействию во время закрытия

    
    func projectedLocation(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        let velosityOffset = velocity(in: view).projectionOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view!) + velosityOffset
        
        return projectedLocation
    }
}

extension CGPoint {
    //MARK: - методы относящиеся к взаимодействию во время закрытия

    func projectionOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint{
        return CGPoint.init(x: x.projectedOffset(decelerationRate: decelerationRate),
                            y: y.projectedOffset(decelerationRate: decelerationRate))
    }
    
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint.init(x: left.x + right.x,
                            y: left.y + right.y)
    }
}

extension CGFloat {
    //MARK: - методы относящиеся к взаимодействию во время закрытия

    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        return self * multiplier
    }
}
