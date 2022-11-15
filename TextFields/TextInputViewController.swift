//
//  TextInputViewController.swift
//  TextFields
//
//  Created by Beavean on 09.11.2022.
//

import UIKit

class TextInputViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardDismissal()
    }
    
    //MARK: - Keyboard dismissal methods
    
    func addKeyboardDismissal() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.showBlueBorder(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.showBlueBorder(false)
    }
}
