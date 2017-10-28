//
//  QHPlayViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/29.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHPlayViewController: QHBaseViewController, QHNavigationBarDelegate {
    
    @IBOutlet weak var navigationBar: QHNavigationBar!
    
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
//        navigationBar.titleLabel.text = "视频播放页"
//        navigationBar.delegate = self
    }
    
    //MARK: QHNavigationBarDelegate
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}
