//
//  QHRootScrollViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/25.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHRootScrollViewController: QHBaseViewController, QHNavigationControllerProtocol {
    
    @IBOutlet weak var mainScrollV: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainScrollV.contentOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
    }
    
    //MARK: QHNavigationControllerProtocol
    
    func navigationControllerShouldPush(_ vc: QHNavigationController) -> Bool {
        let v = self.childViewControllers[1] as! QHTabBarViewController
        //条件1
        var bScrollBegin =  v.navigationControllerShouldPush()
        
        //条件2
        if bScrollBegin == true {
            if mainScrollV.contentOffset.x == mainScrollV.frame.size.width {
                //手势push触发前关闭scrollView滑动
                mainScrollV.isScrollEnabled = false
                bScrollBegin = true
            }
            else {
                bScrollBegin = false
            }
        }
        return bScrollBegin
    }
    
    func navigationControllerDidPushBegin(_ vc: QHNavigationController) -> Bool {
        let v = self.childViewControllers[1] as! QHTabBarViewController
        return v.navigationControllerDidPushBegin()
    }
    
    func navigationControllerDidPushEnd(_ vc: QHNavigationController) {
        //手势push触发后重新开启scrollView滑动
        let v = self.childViewControllers[1] as! QHTabBarViewController
        if v.selectedIndex == 0 {
            mainScrollV.isScrollEnabled = true
        }
    }
    
    func doNavigationControllerGesturePush(_ vc: QHNavigationController) -> Bool {
        //当root scrollview不在tabView时忽略导航push手势
        if mainScrollV.contentOffset.x < mainScrollV.frame.size.width {
            return false
        }
        return true
    }
}
