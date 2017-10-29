//
//  QHRootScrollViewController.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/25.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

class QHRootScrollViewController: QHBaseViewController, QHNavigationControllerProtocol {
    
    @IBOutlet weak var mainScrollV: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainScrollV.contentOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: QHNavigationControllerProtocol
    
    func doNavigationControllerGesturePush(_ vc: QHNavigationController) -> Bool {
        return true
    }
}
