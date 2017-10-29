//
//  QHPresentPopTransition.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/29.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHPresentPopTransition: QHBaseTransition {
    
    let offSetHeight: CGFloat = 0
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        toVC?.view.frame = (fromVC?.view.frame)!
        containerView.addSubview((toVC?.view)!)
        
        containerView.addSubview(fromVC!.view)
        
        let toViewFrame = CGRect(x: 0, y: fromVC!.view.frame.size.height - offSetHeight, width: fromVC!.view.frame.size.width, height: fromVC!.view.frame.size.height + offSetHeight)
        UIView.animate(withDuration: transitionDuration, delay: 0, options: .curveEaseOut, animations: {
            fromVC?.view.frame = toViewFrame
        }) { (bFinish) in
            fromVC?.view.frame = toViewFrame
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
