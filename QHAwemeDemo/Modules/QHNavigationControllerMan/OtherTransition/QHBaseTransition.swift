//
//  QHBaseTransition.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/29.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHBaseTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionDuration: TimeInterval = 0.3
    
    //MARK: UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
