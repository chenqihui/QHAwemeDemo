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
    
    func tabBarViewForMiddle(_ tabBarView: QHTabBarView, size: CGSize) -> UIView?
}

@objc protocol QHTabBarDelegate: NSObjectProtocol {
    @objc optional func tabBarView(_ tabBarView: QHTabBarView, didSelectRowAt index: Int)
}

public class QHTabBarView: UIView {
    
    weak var dataSource: QHTabBarDataSource?
    
    weak var delegate: QHTabBarDelegate?
    
    var superView: UIView?
    
    var selectIndex: Int = 0//从1开始
    
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
        superView!.backgroundColor = UIColor.clear
        
        if let dataS = self.dataSource {
            let dataArray = dataS.tabBarViewForRows(self)
            
            var width = CGFloat(self.frame.size.width) / CGFloat(dataArray.count + 1)
            let hight = CGFloat(self.frame.size.height)
            
            let middleView = dataS.tabBarViewForMiddle(self, size: CGSize(width: width, height: hight))
            
            var middleIndex = Int(dataArray.count) / 2
            if nil == middleView {
                width = CGFloat(self.frame.size.width) / CGFloat(dataArray.count)
                middleIndex = 0
            }
            
            var xIndex = 0
            for (index, value) in dataArray.enumerated() {
                xIndex = index
                if xIndex >= middleIndex && middleIndex != 0 {
                    xIndex += 1
                }
                
                if index == middleIndex && middleIndex != 0 {
                    let view = UIView(frame: CGRect(x: CGFloat(middleIndex) * width, y: 0, width: width, height: hight))
                    view.backgroundColor = UIColor.clear
                    view.addSubview(middleView!)
                    superView!.addSubview(view)
                }
                
                let btn = UIButton(type: UIButtonType.custom)
                btn.frame = CGRect(x: CGFloat(xIndex) * width, y: 0, width: width, height: hight)
                btn.backgroundColor = UIColor.clear
                
                let normalTitle = NSMutableAttributedString(string: value.title, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.gray])
                btn.setAttributedTitle(normalTitle, for: UIControlState.normal)
                
                let selectTitle = NSMutableAttributedString(string: value.title, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.white])
                btn.setAttributedTitle(selectTitle, for: UIControlState.selected)
                
                btn.addTarget(self, action: #selector(QHTabBarView.selectAction(sender:)),for: UIControlEvents.touchUpInside)
                btn.isSelected = false
                btn.tag = index + 1
                
                superView!.addSubview(btn)
            }
        }
        
        self.addSubview(superView!)
    }
    
    func selectTabBar(index: Int) {
        if index == selectIndex {
            return
        }
        if let btn: UIButton = superView?.viewWithTag(index) as? UIButton {
            if let btn: UIButton = superView?.viewWithTag(selectIndex) as? UIButton {
                btn.isSelected = false
            }
            btn.isSelected = true
            selectIndex = index
        }
    }
    
    //MARK: Action
    
    @objc func selectAction(sender: UIButton) {
        if let del = self.delegate {
            if (del.tabBarView) != nil {
                del.tabBarView?(self, didSelectRowAt: (sender.tag - 1))
            }
            
            selectTabBar(index: sender.tag)
        }
    }
}
