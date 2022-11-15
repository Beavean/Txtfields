//
//  OnlyCharactersView.swift
//  TextFields
//
//  Created by Beavean on 31.10.2022.
//

import UIKit

final class OnlyCharactersView: TextFieldSectionView {
    
    private let viewModel: OnlyCharactersViewModel
    
    init(viewModel: OnlyCharactersViewModel = OnlyCharactersViewModel()) {
        self.viewModel = viewModel
        super.init(textFieldPlaceholder: "wwwww-ddddd", leadingTitle: "Only characters")
        inputTextField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        setAccessibilityIdentifiers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAccessibilityIdentifiers() {
        inputTextField?.accessibilityIdentifier = "onlyCharactersTextField"
        leftLabel?.accessibilityIdentifier = "onlyCharactersLeftLabel"
    }
    
    @objc private func textFieldDidChange() {
        inputTextField?.text = viewModel.formatInput(fromString: inputTextField?.text)
    }
}
