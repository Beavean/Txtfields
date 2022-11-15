//
//  NoDigitsView.swift
//  TextFields
//
//  Created by Beavean on 30.10.2022.
//

import UIKit

final class NoDigitsView: TextFieldSectionView {
    
    private let viewModel: NoDigitsViewModel
    
    init(viewModel: NoDigitsViewModel = NoDigitsViewModel()) {
        self.viewModel = viewModel
        super.init(textFieldPlaceholder: "Type here", leadingTitle: "NO digits field")
        inputTextField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        setAccessibilityIdentifiers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAccessibilityIdentifiers() {
        inputTextField?.accessibilityIdentifier = "noDigitsTextField"
        leftLabel?.accessibilityIdentifier = "noDigitsLeftLabel"
    }
        
    @objc private func textFieldDidChange() {
        inputTextField?.text = viewModel.removeDigits(fromString: inputTextField?.text)
    }
}
