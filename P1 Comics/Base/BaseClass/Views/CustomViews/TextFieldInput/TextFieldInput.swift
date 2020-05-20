//
//  CustomTextField.swift
//  FiinClone
//
//  Created by ToRing on 9/18/19.
//  Copyright © 2019 FiinClone. All rights reserved.
//

import UIKit

class TextFieldInput: UITextField {
    @IBInspectable var imageSize: CGFloat = 24
    @IBInspectable var imageMarginIn: CGFloat = 8
    @IBInspectable var imageMarginOut: CGFloat = 0
    @IBInspectable var imagePadding: CGFloat = 0
    @IBInspectable var lineMargin: CGFloat = 0 {
        didSet {
            self.bottomLine.frame = CGRect(x: lineMargin, y: height - lineHeight, width: width - 2 * lineMargin, height: lineHeight)
        }
    }
    @IBInspectable var lineHeight: CGFloat = 1 {
        didSet {
            self.bottomLine.frame = CGRect(x: lineMargin, y: height - lineHeight, width: width - 2 * lineMargin, height: lineHeight)
        }
    }
    @IBInspectable var lineColor: UIColor? = .lightGray {
        didSet {
            if !self.isEditing {
                self.bottomLine.backgroundColor = lineColor
            }
        }
    }
    @IBInspectable var selectedLineColor: UIColor? = .green {
        didSet {
            if self.isEditing {
                self.bottomLine.backgroundColor = selectedLineColor
            }
        }
    }
    @IBInspectable var leftImage: UIImage? {
        willSet {
            if let newValue = newValue {
                self.addImage(direction: .left,
                              image: newValue,
                              marginIn: imageMarginIn,
                              marginOut: imageMarginOut,
                              padding: imagePadding)
            } else {
                self.leftView = nil
            }
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        willSet {
            if let newValue = newValue {
                self.addImage(direction: .right,
                              image: newValue,
                              marginIn: imageMarginIn,
                              marginOut: imageMarginOut,
                              padding: imagePadding)
            } else {
                self.rightView = nil
            }
        }
    }
    
    var leftImageAction: (()->Void)?
    var rightImageAction: (()->Void)?
    
    lazy var bottomLine: UIView = {
        let viewBottomLine = UIView(frame: CGRect(x: lineMargin, y: height - lineHeight, width: width - 2 * lineMargin, height: lineHeight))
        viewBottomLine.backgroundColor = .gray
        return viewBottomLine
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bottomLine.frame = CGRect(x: lineMargin, y: height - lineHeight, width: width - 2 * lineMargin, height: lineHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        self.addSubview(bottomLine)
        
        self.addTarget(self, action: #selector(self.editingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.editingDidEnd), for: .editingDidEnd)
    }
    
    func addImage(direction: ImageDirection, image: UIImage?, marginIn: CGFloat,  marginOut: CGFloat, padding: CGFloat){
        
        if(direction == ImageDirection.left){ // image left
            let view = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: imageSize + marginIn + marginOut,
                                            height: height))
            view.backgroundColor = .clear
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: padding + marginOut,
                                     y: (height - imageSize) / 2.0,
                                     width: imageSize - padding * 2,
                                     height: imageSize - padding * 2)
            view.addSubview(imageView)
            
            self.leftViewMode = .always
            self.leftView = view
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchLeftImage(_:))))
        } else { // image right
            let view = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: imageSize + marginIn + marginOut,
                                            height: height))
            view.backgroundColor = .clear
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: padding + marginIn,
                                     y: (height - imageSize) / 2.0,
                                     width: imageSize - padding * 2,
                                     height: imageSize - padding * 2)
            view.addSubview(imageView)
            
            self.rightViewMode = .always
            self.rightView = view
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchRightImage(_:))))
        }
    }
    
    @objc func editingDidBegin() {
        UIView.animate(withDuration: 0.2) {
            self.bottomLine.backgroundColor = self.selectedLineColor
        }
    }
    
    @objc func editingDidEnd() {
        UIView.animate(withDuration: 0.2) {
            self.bottomLine.backgroundColor = self.lineColor
        }
    }
    
    @objc func touchLeftImage(_ sender: UITapGestureRecognizer) {
        self.leftImageAction?()
    }
    
    @objc func touchRightImage(_ sender: UITapGestureRecognizer) {
        self.rightImageAction?()
    }
}
