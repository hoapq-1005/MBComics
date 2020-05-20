//
//  EmptyView.swift
//  FiinClone
//
//  Created by ToRing on 10/22/19.
//  Copyright © 2019 FiinClone. All rights reserved.
//

import Foundation
import UIKit

class EmptyView: BaseCustomNibView {
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBInspectable var title: String {
        set {
            self.labelTitle.text = newValue
        }
        get {
            return self.labelTitle.text ?? ""
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
