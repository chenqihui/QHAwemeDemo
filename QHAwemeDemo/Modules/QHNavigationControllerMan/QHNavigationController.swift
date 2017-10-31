//
//  QHNavigationController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/23.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

@objc public protocol QHNavigationControllerProtocol : NSObjectProtocol {
    //页面是否有push的Action
    @objc optional func navigationControllerShouldPush(_ vc: QHNavigationController) -> Bool
    
    //页面执行push的Action，返回true，会在End触发rootView的End回调事件（暂时为了业务需求，后期寻找优化方案）
    @objc optional func navigationControllerDidPushBegin(_ vc: QHNavigationController) -> Bool
    //只执行rootView
    @objc optional func navigationControllerDidPushEnd(_ vc: QHNavigationController)
    
    //页面是否支持手势push
    func doNavigationControllerGesturePush(_ vc: QHNavigationController) -> Bool
    
    @objc optional func doNavigationControllerGesturePop(_ vc: QHNavigationController) -> Bool
}

public class QHNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var currentShowVC: UIViewController?
    
    var edgePan: UIScreenEdgePanGestureRecognizer?
    
    var transition = QHNavigationControllerTransition()
    var pan: UIPanGestureRecognizer?
    
    var bResetScrollEable = false
    
    //TODO: 暂时使用其他push动画时，禁止手势pop
    var otherTransition: QHNavigationOtherTransition?

    override public func viewDidLoad() {
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
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open var shouldAutorotate: Bool {
        if let b = viewControllers.last?.shouldAutorotate {
            return b
        }
        return true
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (viewControllers.last?.supportedInterfaceOrientations)!
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (viewControllers.last?.preferredInterfaceOrientationForPresentation)!
    }
    
    override open var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    //MARK: Public
    
    public func changeTransition(_ bChange: Bool) {
        if bChange == true {
            if otherTransition == nil {
                otherTransition = QHNavigationOtherTransition()
            }
            self.delegate = otherTransition
        }
        else {
            self.delegate = self;
        }
    }
    
    //MARK: UINavigationControllerDelegate
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
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
    
    //MARK: UIGestureRecognizerDelegate
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if let _ = otherTransition {
                if self.delegate is QHNavigationOtherTransition {
                    return false
                }
            }
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
//        else if gestureRecognizer == edgePan {
//            if self.topViewController is QHRootScrollViewController {
//                let vc = self.topViewController as! QHRootScrollViewController
//                vc.mainScrollV.isScrollEnabled = false
//                gestureRecognizer.addTarget(transition, action: #selector(QHNavigationControllerTransition.gestureDidPushed(_:)))
//                return true
//            }
//            return false
//        }
        else if gestureRecognizer == pan {
            var bEnble = false
            //判断是否打开手势push
            if self.topViewController is QHNavigationControllerProtocol {
                let v = self.topViewController as! QHNavigationControllerProtocol
                bEnble = v.doNavigationControllerGesturePush(self)
            }
            if bEnble == false {
                return false
            }
            //判断条件是否满足手势push
            let gesture = gestureRecognizer as! UIPanGestureRecognizer
            let translation = gesture.velocity(in: gesture.view)
            //条件：手势方向为：水平向左
            if translation.x < 0 && abs(translation.x) > abs(translation.y) {
                var bScrollBegin = false
                let vc = self.topViewController
                //判断是否包含有可运行手势push的Action
                if vc is QHNavigationControllerProtocol {
                    if (vc?.responds(to: #selector(QHNavigationControllerProtocol.navigationControllerShouldPush(_:))))! {
                        let v = vc as! QHNavigationControllerProtocol
                        bScrollBegin = v.navigationControllerShouldPush!(self)
                    }
                }
                if bScrollBegin == true {
                    gesture.addTarget(transition, action: #selector(QHNavigationControllerTransition.gestureDidPushed(_:)))
                }
                return bScrollBegin
            }
        }
        return false
    }
    
    //MARK: Action
    
    @objc func gestureDidPushed(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let vc = self.topViewController
            if (vc?.responds(to: #selector(QHNavigationControllerProtocol.navigationControllerDidPushBegin(_:))))! {
                let v = vc as! QHNavigationControllerProtocol
                self.delegate = transition
                bResetScrollEable = v.navigationControllerDidPushBegin!(self)
            }
        }
        else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            self.delegate = self;
            if bResetScrollEable == true {
                
                let vc = self.viewControllers.first
                if (vc?.responds(to: #selector(QHNavigationControllerProtocol.navigationControllerDidPushEnd(_:))))! {
                    let v = vc as! QHNavigationControllerProtocol
                    v.navigationControllerDidPushEnd!(self)
                }
                
                bResetScrollEable = false
            }
            gestureRecognizer.addTarget(self, action: #selector(QHNavigationController.gestureDidPushed(_:)))
        }
    }
    
}
