//
//  ViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/15.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class ViewController: QHTabBarController {
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
    }
    
    //MARK: QHTabBarDataSource
    
    override func tabBarViewForRows(_ tabBarView: QHTabBarView) -> [QHTabBar] {
        return dataArray
    }
    
    //MARK: QHTabBarDelegate
    
    override func tabBarView(_ tabBarView: QHTabBarView, didSelectRowAt index: Int) {
        super.tabBarView(tabBarView, didSelectRowAt: index)
    }
}

