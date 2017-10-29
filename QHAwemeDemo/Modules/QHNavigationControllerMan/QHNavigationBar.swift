//
//  QHNavigationBar.swift
//  SHQFLiveScreenStreamAssistant
//
//  Created by Anakin chen on 2017/6/18.
//  Copyright © 2017年 Qianjun Network Technology. All rights reserved.
//

import UIKit

public protocol QHNavigationBarDelegate: NSObjectProtocol {
    func backAction()
}

class QHNavigationBar: UIView {
    
    weak open var delegate: QHNavigationBarDelegate?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        p_setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("QHNavigationBar", owner: self, options: nil)
//        self.frame = self.view.frame
        self.addSubview(self.view)
        p_setup()
    }
    
    func p_setup() {
    }

    @IBAction func backAction(_ sender: Any) {
        delegate?.backAction()
    }
}
