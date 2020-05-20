//
//  LoadingView.swift
//  SwiftBase
//
//  Created by ToRing on 9/10/19.
//  Copyright © 2019 SwiftBase. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewBlurBackground: UIView!
    
    /// Có hiển thị lớp blur không?
    @IBInspectable var blurBackground: Bool {
        set {
            viewBlurBackground.isHidden = !newValue
        }
        get {
            return !viewBlurBackground.isHidden
        }
    }
    
    /// Màu lớp blur
    @IBInspectable var blurBackgroundColor: UIColor? {
        set {
            viewBlurBackground.backgroundColor = newValue
        }
        get {
            return viewBlurBackground.backgroundColor
        }
    }
    
    /// Độ mờ của lớp blur
    @IBInspectable var blurAlpha: CGFloat {
        set {
            viewBlurBackground.alpha = newValue
        }
        get {
            return viewBlurBackground.alpha
        }
    }
    
    /// Màu background của loading
    @IBInspectable var loadingBackground: UIColor? {
        set {
            activityIndicator.backgroundColor = newValue
        }
        
        get {
            return activityIndicator.backgroundColor
        }
    }
    
    /// Màu của Loading
    @IBInspectable var loadingColor: UIColor {
        set {
            activityIndicator.color = newValue
        }
        get {
            return activityIndicator.color
        }
    }

    /// Loading type
    @IBInspectable var loadingType: UIActivityIndicatorView.Style {
        set {
            activityIndicator.style = newValue
        }
        get {
            return activityIndicator.style
        }
    }
    
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
        let nib = UINib(nibName: "LoadingView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        blurBackground = false
        blurBackgroundColor = .black
        blurAlpha = 0.4
        loadingBackground = .white
        loadingType = .gray
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
