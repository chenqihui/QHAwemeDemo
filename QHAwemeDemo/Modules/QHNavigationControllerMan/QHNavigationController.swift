//
//  QHNavigationController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/23.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

@objc protocol QHNavigationControllerProtocol : NSObjectProtocol {
    @objc optional func navigationControllerDidPush(_ vc: QHNavigationController)
    
    @objc optional func doNavigationControllerGesturePush(_ vc: QHNavigationController) -> Bool
    
    @objc optional func doNavigationControllerGesturePop(_ vc: QHNavigationController) -> Bool
}

class QHNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var currentShowVC: UIViewController?
    
    var edgePan: UIScreenEdgePanGestureRecognizer?
    
    var transition = QHNavigationControllerTransition()
    var pan: UIPanGestureRecognizer?
    
    var bResetScrollEable = false

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
            if self.topViewController is QHNavigationControllerProtocol {
                let v = self.topViewController as! QHNavigationControllerProtocol
                if (v.doNavigationControllerGesturePop) != nil {
                    let bEnble = v.doNavigationControllerGesturePop!(self)
                    return bEnble
                }
            }
            
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
            var bEnble = true
            if self.topViewController is QHNavigationControllerProtocol {
                let v = self.topViewController as! QHNavigationControllerProtocol
                if (v.doNavigationControllerGesturePush) != nil {
                    bEnble = v.doNavigationControllerGesturePush!(self)
                }
            }
            if bEnble == false {
                return false
            }
            
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
                var bScrollBegin = false
                let vc = self.topViewController
                if vc is QHRootScrollViewController {
                    let vc = self.topViewController as! QHRootScrollViewController
                    //手势push触发前，关闭root的scrollView滑动
                    if vc.mainScrollV.contentOffset.x == vc.mainScrollV.frame.size.width {
                        vc.mainScrollV.isScrollEnabled = false
                        bScrollBegin = true
                    }
                }
                else if (vc?.responds(to: #selector(QHNavigationControllerProtocol.navigationControllerDidPush(_:))))! {
                    bScrollBegin = true
                }
                if bScrollBegin == true {
                    gesture.addTarget(transition, action: #selector(QHNavigationControllerTransition.gestureDidPushed(_:)))
                }
                return bScrollBegin
            }
        }
        return false
    }
    
    @objc func gestureDidPushed(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let vc = self.topViewController
            if vc is QHRootScrollViewController {
                let v = vc as! QHRootScrollViewController
                let vv = v.childViewControllers[1] as! QHNavigationControllerProtocol
                self.delegate = transition
                vv.navigationControllerDidPush!(self)
                
                bResetScrollEable = true
            }
            else if (vc?.responds(to: #selector(QHNavigationControllerProtocol.navigationControllerDidPush(_:))))! {
                let v = vc as! QHNavigationControllerProtocol
                self.delegate = transition
                v.navigationControllerDidPush!(self)
                
                bResetScrollEable = false
            }
        }
        else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            self.delegate = self;
            //手势push触发后重新开启root的scrollView滑动
            if bResetScrollEable == true {
                let vc = self.viewControllers.first as! QHRootScrollViewController
                vc.mainScrollV.isScrollEnabled = true
                
                bResetScrollEable = false
            }
            gestureRecognizer.addTarget(self, action: #selector(QHNavigationController.gestureDidPushed(_:)))
        }
    }
    
}
