//
//  Extensions.swift
//  TextFields
//
//  Created by Beavean on 24.10.2022.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func setDimensions(height: CGFloat? = nil, width: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showRedBorder(_ present: Bool) {
        layer.borderColor = UIColor.systemRed.cgColor
        layer.borderWidth = present ? 2 : 0
    }
    
    func showBlueBorder(_ present: Bool) {
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = present ? 2 : 0
    }
    
    func createLabel(withTitle title: String?, fontSize: CGFloat = 14) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: fontSize)
        label.setDimensions(height: 18)
        return label
    }
}
