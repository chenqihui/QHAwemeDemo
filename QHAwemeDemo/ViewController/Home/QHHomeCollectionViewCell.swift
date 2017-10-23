//
//  QHHomeCollectionViewCell.swift
//  QHAwemeDemo
//
//  Created by Anakin chen on 2017/10/22.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

import UIKit

public protocol QHHomeCollectionViewCellDelegate: NSObjectProtocol {
    
    func showDetails(_ view: QHHomeCollectionViewCell)
}

public class QHHomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleL: UILabel!
    
    weak var delegate: QHHomeCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        p_setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        p_setup()
    }
    
    //MARK: Private
    
    func p_setup() {
    }
    
    //MARK: Action
    
    @IBAction func showDetailsAction(_ sender: Any) {
        if let del = delegate {
            del.showDetails(self)
        }
    }
    
}
