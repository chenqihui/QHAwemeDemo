//
//  QHDetailsViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/22.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHDetailsViewController: QHBaseViewController, QHNavigationBarDelegate {

    @IBOutlet weak var naviBar: QHNavigationBar!
    
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
        naviBar.titleLabel.text = "个人主页"
        naviBar.delegate = self
    }
    
    //MARK: QHNavigationBarDelegate
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Action
    
    @IBAction func goPlayViewAction(_ sender: Any) {
        let vc = QHPlayViewController()
        vc.tipTitleString = "由于是从个人主页进入的播放页，所以屏蔽手势push进入个人主页，业务上避免循环了。这也跟抖音一样的逻辑"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
