//
//  QHTabBarController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/15.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

public struct QHTabBar {
    var storyboardName: String = ""
    var title: String = ""
    var icon: String = ""
    var selectIcon: String = ""
    
    static func Null() -> QHTabBar {
        return QHTabBar();
    }
}

class QHTabBarController: UITabBarController, QHTabBarDataSource, QHTabBarDelegate {
    
    var tabBarView: QHTabBarView = QHTabBarView(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        p_addTabBarView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private
    
    func p_addTabBarView() {
        let frame = self.tabBar.frame
        tabBarView.frame = frame
        tabBarView.dataSource = self
        tabBarView.delegate = self
        self.view.addSubview(tabBarView)
        
        self.tabBar.isHidden = true
        
    }
    
    //MARK: Public
    
    func addChildVCWithStoryboardName(tabBar: QHTabBar) {
        let storyboard = UIStoryboard(name: tabBar.storyboardName, bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() {
            self.addChildViewController(vc)
        }
    }
    
    func selectIndexView(index: Int) {
        self.selectedIndex = index - 1
        self.tabBarView.selectTabBar(index: index)
    }
    
    //MARK: Util
    
    func createImageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return theImage!;
    }
    
    //MARK: QHTabBarDataSource
    
    func tabBarViewForRows(_ tabBarView: QHTabBarView) -> [QHTabBar] {
        return [QHTabBar()]
    }
    
    func tabBarViewForMiddle(_ tabBarView: QHTabBarView, size: CGSize) -> UIView? {
        return nil
    }
    
    //MARK: QHTabBarDelegate
    
    func tabBarView(_ tabBarView: QHTabBarView, didSelectRowAt index: Int) {
        self.selectedIndex = index
    }

}
