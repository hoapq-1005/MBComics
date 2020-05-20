//
//  EmptyView.swift
//
//  Created by HoaPQ on 10/22/19.
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
