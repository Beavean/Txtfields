//
//  InputLimitView.swift
//  TextFields
//
//  Created by Beavean on 30.10.2022.
//

import Foundation

final class InputLimitView: TextFieldSectionView {
    
    private let viewModel: InputLimitViewModel
    
    init(viewModel: InputLimitViewModel = InputLimitViewModel()) {
        self.viewModel = viewModel
        super.init(textFieldPlaceholder: "Type here", leadingTitle: "Input limit", trailingTitle: "0/\(viewModel.inputLimit)")
        inputTextField?.addTarget(self, action: #selector(inputLimitTextFieldDidChange), for: .editingChanged)
        setAccessibilityIdentifiers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAccessibilityIdentifiers() {
        inputTextField?.accessibilityIdentifier = "InputLimitTextField"
        leftLabel?.accessibilityIdentifier = "inputLimitLeftLabel"
        rightLabel?.accessibilityIdentifier = "inputLimitRightLabel"
    }
    
    @objc private func inputLimitTextFieldDidChange() {
        let string = inputTextField?.text
        inputTextField?.attributedText = viewModel.createOutputAndCheckLimit(fromString: string)
        rightLabel?.attributedText = viewModel.indicateLimit(fromString: string)
        viewModel.checkInputForLimit(fromString: string) ? inputTextField?.showRedBorder(true) : inputTextField?.showBlueBorder(true)
    }
}
