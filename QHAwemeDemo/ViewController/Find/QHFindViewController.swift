//
//  QHFindViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/16.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHFindViewController: QHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action
    
    @IBAction func goPlayAction(_ sender: Any) {
        let vc = QHPlayViewController()
        vc.bEnblePush = true
        vc.tipTitleString = "由于不是从个人主页进入的播放页，所以可以手势push进入个人主页"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
