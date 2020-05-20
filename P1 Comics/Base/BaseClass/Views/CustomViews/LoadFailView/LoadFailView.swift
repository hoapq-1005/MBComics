//
//  LoadFailView.swift
//
//  Created by HoaPQ on 9/27/19.
//

import Foundation
import UIKit

class LoadFailView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var buttonTryAgain: UIButton!
    
    var buttonAction: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Setup default value
    func commonInit() {
        let nib = UINib(nibName: "LoadFailView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        setupView()
    }
    
    func setupView() {
        self.buttonTryAgain.setTitle("Try Again", for: .normal)
    }
    
    @IBAction func touchButtonTryAgain(_ sender: Any) {
        buttonAction?()
    }
    
    func setErrorMessage(errorMessage: String) {
        self.labelError.text = errorMessage
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
