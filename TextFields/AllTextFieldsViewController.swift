//
//  TextFieldsViewController.swift
//  TextFields
//
//  Created by Beavean on 30.10.2022.
//

import Foundation
import UIKit

final class AllTextFieldsViewController: TextInputViewController {
    
    //MARK: - UI Elements
    
    private let noDigitsView = NoDigitsView()
    private let inputLimitView = InputLimitView()
    private let onlyCharactersView = OnlyCharactersView()
    private let linkView = LinkView()
    private let validationRulesView = ValidationRulesView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Text Fields"
        label.font = .boldSystemFont(ofSize: 38)
        return label
    }()
    
    private lazy var showTabControllerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.configuration = .filled()
        button.setTitle("Show Tab Controller", for: .normal)
        button.addTarget(self, action: #selector(handleShowTabController), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    private let defaultPadding: CGFloat = 16
    private var linkTextFieldTimer: Timer?
    private var textFields = [UITextField?]()
    private var lowestInterfaceElement: UIView { showTabControllerButton }
    private var underKeyboardTextFieldEditing: Bool {
        onlyCharactersView.textFieldIsFirstResponder
        || linkView.textFieldIsFirstResponder
        || validationRulesView.textFieldIsFirstResponder
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
        setupTextFields()
        setAccessibilityIdentifiers()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        let customViewStack = UIStackView(arrangedSubviews: [noDigitsView, inputLimitView, onlyCharactersView, linkView, validationRulesView])
        view.addSubview(customViewStack)
        view.addSubview(showTabControllerButton)
        
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: defaultPadding)
        
        customViewStack.axis = .vertical
        customViewStack.distribution = .fillProportionally
        customViewStack.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: defaultPadding, paddingLeft: defaultPadding, paddingRight: defaultPadding)
        showTabControllerButton.anchor(top: validationRulesView.lowestInterfaceElement.bottomAnchor, paddingTop: defaultPadding)
        showTabControllerButton.centerX(inView: view)
    }
    
    private func setupTextFields() {
        textFields = [noDigitsView.inputTextField,
                      inputLimitView.inputTextField,
                      onlyCharactersView.inputTextField,
                      linkView.inputTextField,
                      validationRulesView.inputTextField]
        addInputAccessoryForTextFields(textFields: textFields)
        textFields.forEach { textField in
            textField?.delegate = self
            textField?.returnKeyType = .next

        }
    }
    
    private func addInputAccessoryForTextFields(textFields: [UITextField?]) {
        for (index, textField) in textFields.enumerated() {
            guard let textField else { return }
            let toolbar: UIToolbar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.width, height: 70)))
            
            var items = [UIBarButtonItem]()
            let previousButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: nil, action: nil)
            previousButton.width = 60
            if textField == textFields.first {
                previousButton.isEnabled = false
            } else {
                previousButton.target = textFields[index - 1]
                previousButton.action = #selector(UITextField.becomeFirstResponder)
            }
            
            let nextButton = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: nil, action: nil)
            nextButton.width = 60
            if textField == textFields.last {
                nextButton.isEnabled = false
            } else {
                nextButton.target = textFields[index + 1]
                nextButton.action = #selector(UITextField.becomeFirstResponder)
            }
            items.append(contentsOf: [previousButton, nextButton])
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            
            items.append(contentsOf: [spacer, doneButton])
            
            toolbar.setItems(items, animated: false)
            toolbar.sizeToFit()
            textField.inputAccessoryView = toolbar
        }
    }
    
    private func configureNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setAccessibilityIdentifiers() {
        titleLabel.accessibilityIdentifier = "titleLabel"
        showTabControllerButton.accessibilityIdentifier = "showTabControllerButton"
    }
    
    //MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let selectedTextField = textField
        var textFieldIndex = 0
        for (index, textField) in textFields.enumerated() {
            if let textField = textField, textField == selectedTextField {
                textFieldIndex = index == textFields.count - 1 ? 0 : index + 1
                textFields[textFieldIndex]?.becomeFirstResponder()
            }
        }
        return true
    }
    
    //MARK: - Selectors
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let lowestFrame = lowestInterfaceElement.superview?.convert(lowestInterfaceElement.frame, to: nil)
        else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        if underKeyboardTextFieldEditing && view.frame.origin.y == 0 {
            let frameOriginY = self.view.frame.origin.y - keyboardHeight + (view.frame.height - lowestFrame.maxY - defaultPadding)
            self.view.frame.origin.y = frameOriginY
        } else if !underKeyboardTextFieldEditing && view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc private func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func handleShowTabController() {
        self.navigationController?.pushViewController(TabBarController(), animated: true)
    }
}
