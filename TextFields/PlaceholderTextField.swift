//
//  PlaceholderTextField.swift
//  TextFields
//
//  Created by Beavean on 24.10.2022.
//

import UIKit

final class PlaceholderTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 30)
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.font = .systemFont(ofSize: 18)
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 10
        self.clearButtonMode = .always
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.spellCheckingType = .no
        self.smartQuotesType = .no
        self.setDimensions(height: 40)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
