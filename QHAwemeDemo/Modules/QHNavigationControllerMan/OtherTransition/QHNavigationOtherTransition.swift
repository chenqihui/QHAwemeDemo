//
//  QHNavigationOtherTransition.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/29.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHNavigationOtherTransition: NSObject, UINavigationControllerDelegate {

    let kQHNavigationControllerTransitionBorderlineDelta = 0.3
    
    //MARK: UINavigationControllerDelegate
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return QHPresentPushTransition()
        }
        else if operation == .pop {
            return QHPresentPopTransition()
        }
        return nil
    }
}
