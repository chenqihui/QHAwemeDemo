//
//  QHPlayViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/29.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHPlayViewController: QHBaseViewController, QHNavigationBarDelegate, QHNavigationControllerProtocol {
    
    @IBOutlet weak var naviBar: QHNavigationBar!
    
    @IBOutlet weak var tipTitleL: UILabel!
    
    var bEnblePush = false
    
    var tipTitleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        p_setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private
    
    func p_setup() {
        naviBar.titleLabel.text = "视频播放"
        naviBar.delegate = self
        
        if let s = tipTitleString {
            tipTitleL.text = s
        }
    }
    
    //MARK: QHNavigationControllerProtocol
    
    func navigationControllerShouldPush(_ vc: QHNavigationController) -> Bool {
        return true
    }
    
    func navigationControllerDidPushBegin(_ vc: QHNavigationController) -> Bool {
        let vc = QHDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        return false
    }
    
    func doNavigationControllerGesturePush(_ vc: QHNavigationController) -> Bool {
        return bEnblePush
    }
    
    func doNavigationControllerGesturePop(_ vc: QHNavigationController) -> Bool {
        return true
    }
    
    //MARK: QHNavigationBarDelegate
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}
