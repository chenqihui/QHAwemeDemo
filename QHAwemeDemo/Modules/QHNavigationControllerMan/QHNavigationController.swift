//
//  QHNavigationController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/23.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

protocol QHNavigationControllerProtocol : NSObjectProtocol {
    func navigationControllerDidPush(_ vc: QHNavigationController)
}

class QHNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var currentShowVC: UIViewController?
    
    var edgePan: UIScreenEdgePanGestureRecognizer?
    
    var transition = QHNavigationControllerTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate;
        self.delegate = self;
        
        edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(QHNavigationController.gestureDidPushed(_:)))
        edgePan?.edges = .right
        edgePan?.delegate = self
        self.view.addGestureRecognizer(edgePan!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            self.currentShowVC = nil
        }
        else if animated {
            self.currentShowVC = viewController
        }
        else {
            self.currentShowVC = nil
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            return (self.currentShowVC == self.topViewController)
        }
        else if gestureRecognizer == edgePan {
            gestureRecognizer.addTarget(transition, action: #selector(QHNavigationControllerTransition.gestureDidPushed(_:)))
            return true
        }
        return true
    }
    
    @objc func gestureDidPushed(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
//            let translation = gestureRecognizer.velocity(in: gestureRecognizer.view)

            let vc = self.topViewController
            
            if vc is ViewController {
                let v = vc as! ViewController
                self.delegate = transition
                v.navigationControllerDidPush(self)
            }
        }
        else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            self.delegate = self;
            
            gestureRecognizer.addTarget(self, action: #selector(QHNavigationController.gestureDidPushed(_:)))
        }
    }
    
    func p_addSystomPopAction(_ gestureRecognizer: UIGestureRecognizer) {
        
    }
    
}
