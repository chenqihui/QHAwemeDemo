//
//  QHNavigationController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/23.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

/*
 为UIViewController添加扩展，是否关闭当前pop，全局pop，当前手势push
 */

protocol QHNavigationControllerProtocol : NSObjectProtocol {
    func navigationControllerDidPush(_ vc: QHNavigationController)
}

class QHNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var currentShowVC: UIViewController?
    
    var edgePan: UIScreenEdgePanGestureRecognizer?
    
    var transition = QHNavigationControllerTransition()
    var pan: UIPanGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate;
        self.delegate = self;
        
//        edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(QHNavigationController.gestureDidPushed(_:)))
//        edgePan?.edges = .right
//        edgePan?.delegate = self
//        self.view.addGestureRecognizer(edgePan!)
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(QHNavigationController.gestureDidPushed(_:)))
        pan?.delegate = self
        self.view.addGestureRecognizer(pan!)
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
            let bGesture = self.currentShowVC == self.topViewController
            return bGesture
        }
        else if gestureRecognizer == edgePan {
            if self.topViewController is QHRootScrollViewController {
                let vc = self.topViewController as! QHRootScrollViewController
                vc.mainScrollV.isScrollEnabled = false
                gestureRecognizer.addTarget(transition, action: #selector(QHNavigationControllerTransition.gestureDidPushed(_:)))
                return true
            }
            return false
        }
        else if gestureRecognizer == pan {
            //对根页面类似scrollView的处理，如果没有可以忽略
            if self.topViewController is QHRootScrollViewController {
                let vc = self.topViewController as! QHRootScrollViewController
                if vc.mainScrollV.contentOffset.x < vc.mainScrollV.frame.size.width {//当root scrollview不在tabView时忽略导航push手势
                    return false
                }
            }
            let gesture = gestureRecognizer as! UIPanGestureRecognizer
            let translation = gesture.velocity(in: gesture.view)
            //手势方向为：水平向左
            if translation.x < 0 && abs(translation.x) > abs(translation.y) {
                if self.topViewController is QHRootScrollViewController {
                    let vc = self.topViewController as! QHRootScrollViewController
                    //手势push触发前，关闭root的scrollView滑动
                    if vc.mainScrollV.contentOffset.x == vc.mainScrollV.frame.size.width {
                        vc.mainScrollV.isScrollEnabled = false
                    }
                    else {//暂时忽略其他支持的页面
                        //TODO:修改为判断当前页面是否支持手势push
                        return false
                    }
                }
                gesture.addTarget(transition, action: #selector(QHNavigationControllerTransition.gestureDidPushed(_:)))
                return true
            }
            return false
        }
        return false
    }
    
    @objc func gestureDidPushed(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {

            let vc = self.topViewController
            
            if vc is QHRootScrollViewController {
                let v = vc as! QHRootScrollViewController
                let vv = v.childViewControllers[1] as! QHTabBarViewController
                
                self.delegate = transition
                vv.navigationControllerDidPush(self)
            }
        }
        else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            self.delegate = self;
            //手势push触发后重新开启root的scrollView滑动
            if self.viewControllers.first is QHRootScrollViewController {
                let vc = self.viewControllers.first as! QHRootScrollViewController
                vc.mainScrollV.isScrollEnabled = true
            }
            gestureRecognizer.addTarget(self, action: #selector(QHNavigationController.gestureDidPushed(_:)))
        }
    }
    
}
