//
//  QHDetailsViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/22.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHDetailsViewController: QHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action
    
    @IBAction func goPlayViewAction(_ sender: Any) {
        let vc = QHPlayViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
