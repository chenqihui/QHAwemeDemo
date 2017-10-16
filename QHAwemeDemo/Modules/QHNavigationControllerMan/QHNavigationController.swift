//
//  QHNavigationController.swift
//  SHQFLiveScreenStreamAssistant
//
//  Created by Anakin chen on 2017/6/18.
//  Copyright © 2017年 Qianjun Network Technology. All rights reserved.
//

import UIKit

class QHNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var currentShowVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate;
        self.delegate = self;
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
        return true
    }

}
