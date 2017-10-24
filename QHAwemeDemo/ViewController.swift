//
//  ViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/15.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class ViewController: QHTabBarController, QHNavigationControllerProtocol {
    
    var dataArray: [QHTabBar] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.view.backgroundColor = UIColor.clear
        
        p_setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private
    
    func p_setup() {
        let tabBarHome = QHTabBar.init(storyboardName: "Home", title: "首页", icon: "", selectIcon: "")
        let tabBarFind = QHTabBar.init(storyboardName: "Find", title: "发现", icon: "", selectIcon: "")
        let tabBarMessage = QHTabBar.init(storyboardName: "Message", title: "消息", icon: "", selectIcon: "")
        let tabBarMine = QHTabBar.init(storyboardName: "Mine", title: "我", icon: "", selectIcon: "")
        dataArray = [tabBarHome, tabBarFind, tabBarMessage, tabBarMine]
        
        for value in dataArray {
            addChildVCWithStoryboardName(tabBar: value)
        }
        self.tabBarView.reloadData()
        self.selectIndexView(index: 1)
        p_setTabBarViewColor()
    }
    
    func p_setTabBarViewColor() {
        if self.selectedIndex == 0 {
            self.tabBarView.backgroundColor = UIColor.clear
        }
        else {
            self.tabBarView.backgroundColor = UIColor.black
        }
    }
    
    //MARK: QHTabBarDataSource
    
    override func tabBarViewForRows(_ tabBarView: QHTabBarView) -> [QHTabBar] {
        return dataArray
    }
    
    override func tabBarViewForMiddle(_ tabBarView: QHTabBarView, size: CGSize) -> UIView? {
        let wd = 15 as CGFloat
        let hd = 10 as CGFloat
        let w = CGFloat(size.width) - wd * CGFloat(2)
        let h = CGFloat(size.height) - hd * CGFloat(2)
        let middleBtn = UIButton(frame: CGRect(x: wd, y: hd, width: w, height:h))
        middleBtn.setTitle("+", for: .normal)
        middleBtn.setTitleColor(UIColor.black, for: .normal)
        middleBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        middleBtn.backgroundColor = UIColor.white
        middleBtn.layer.cornerRadius = 3
        
        return middleBtn
    }
    
    //MARK: QHTabBarDelegate
    
    override func tabBarView(_ tabBarView: QHTabBarView, didSelectRowAt index: Int) {
        if self.selectedIndex == index {
            let vc = self.childViewControllers[selectedIndex]
            switch selectedIndex {
            case 0: do {
                let v: QHHomeViewController = vc as! QHHomeViewController
                v.mainCV.reloadData()
                v.mainCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            }
                break
            case 1:
                break
            case 2:
                break
            case 3:
                break
            default:
                break
            }
        }
        else {
            self.selectedIndex = index
            p_setTabBarViewColor()
        }
    }
    
    func navigationControllerDidPush(_ vc: QHNavigationController) {
        
        let vc = self.childViewControllers[selectedIndex]
        switch selectedIndex {
        case 0: do {
            let v: QHHomeViewController = vc as! QHHomeViewController
            v.showDetails()
        }
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
}

