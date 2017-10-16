//
//  QHTabBarView.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/16.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

public protocol QHTabBarDataSource: NSObjectProtocol {
    func tabBarViewForRows(_ tabBarView: QHTabBarView) -> [QHTabBar]
}

public protocol QHTabBarDelegate: NSObjectProtocol {
    func tabBarView(_ tabBarView: QHTabBarView, didSelectRowAt index: Int)
}

public class QHTabBarView: UIView {
    
    weak var dataSource: QHTabBarDataSource?
    
    weak var delegate: QHTabBarDelegate?
    
    var superView: UIView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        p_setup()
        reloadData()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        p_setup()
        reloadData()
    }
    
    //MARK: Private
    
    func p_setup() {
        self.backgroundColor = UIColor.clear
    }
    
    //MARK: Public
    
    func reloadData() {
        superView?.removeFromSuperview()
        superView = UIView(frame: self.bounds)
        superView!.backgroundColor = UIColor.gray
        
        if let dataS = self.dataSource {
            let dataArray = dataS.tabBarViewForRows(self)
            
            let width = CGFloat(self.frame.size.width) / CGFloat(dataArray.count)
            let hight = CGFloat(self.frame.size.height)
            
            for (index, value) in dataArray.enumerated() {
                let btn = UIButton(type: UIButtonType.custom)
                btn.setTitle(value.title, for: UIControlState.normal)
                btn.setTitleColor(UIColor.black, for: UIControlState.normal)
                btn.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: hight)
                btn.addTarget(self, action: #selector(QHTabBarView.selectAction(sender:)),for: UIControlEvents.touchUpInside)
                btn.tag = index + 1
                
                superView!.addSubview(btn)
            }
        }
        
        self.addSubview(superView!)
    }
    
    //MARK: Action
    
    @objc func selectAction(sender: UIButton) {
        if let del = self.delegate {
//            if del.responds(to: #selector(del.tabBarView(_:didSelectRowAt:))) {
                del.tabBarView(self, didSelectRowAt: sender.tag)
//            }
        }
    }
}
