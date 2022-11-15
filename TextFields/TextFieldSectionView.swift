//
//  TextFieldSectionView.swift
//  TextFields
//
//  Created by Beavean on 24.10.2022.
//

import UIKit

class TextFieldSectionView: UIView {
    
    //MARK: - UI Elements
    
    var leftLabel: UILabel?
    var rightLabel: UILabel?
    var inputTextField: UITextField?
    
    //MARK: - Properties
    
    private let inputTextFieldTopPadding: CGFloat = 8
    var textFieldIsFirstResponder: Bool {
        inputTextField?.isFirstResponder ?? false
    }
    
    //MARK: - Lifecycle
    
    init(textFieldPlaceholder: String, leadingTitle: String, trailingTitle: String? = nil) {
        super.init(frame: .zero)
        leftLabel = createLabel(withTitle: leadingTitle)
        rightLabel = createLabel(withTitle: trailingTitle)
        inputTextField = PlaceholderTextField(placeholder: textFieldPlaceholder)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        guard let leftLabel, let inputTextField else { return }
        setDimensions(height: 70)
        addSubview(leftLabel)
        addSubview(inputTextField)
        leftLabel.anchor(top: self.topAnchor, left: self.leftAnchor)
        inputTextField.anchor(top: leftLabel.bottomAnchor,
                              left: self.leftAnchor,
                              right: self.rightAnchor,
                              paddingTop: inputTextFieldTopPadding)
        if let rightLabel {
            addSubview(rightLabel)
            rightLabel.anchor(top: self.topAnchor, right: self.rightAnchor)
        }
    }
}
