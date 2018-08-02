//
//  QHRecordViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/30.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHRecordViewController: QHBaseViewController, QHNavigationBarDelegate {
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        (self.navigationController as? QHNavigationController)?.changeTransition(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
//        (self.navigationController as? QHNavigationController)?.changeTransition(true)
    }
    
    //MARK: Private
    
    func p_setup() {
        naviBar.titleLabel.text = "录制设置"
        naviBar.delegate = self
    }
    
    //MARK: QHNavigationBarDelegate
    
    func backAction() {
        (self.navigationController as? QHNavigationController)?.changeTransition(true)
        self.navigationController?.popViewController(animated: true)
        (self.navigationController as? QHNavigationController)?.changeTransition(false)
    }
    
    //MARK: Action
    
    @IBAction func goAction(_ sender: Any) {
        (self.navigationController as! QHNavigationController).changeTransition(false)
        let vc = QHPlayViewController()
        vc.tipTitleString = "有录制页面进来的"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
