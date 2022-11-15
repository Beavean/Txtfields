//
//  ValidationRulesView.swift
//  TextFields
//
//  Created by Beavean on 31.10.2022.
//

import UIKit

final class ValidationRulesView: TextFieldSectionView {
    
    //MARK: - UI Elements
    
    private let viewModel: ValidationRulesViewModel
    private let validationRulesView = TextFieldSectionView(textFieldPlaceholder: "Type here", leadingTitle: "Validation rules")
    private lazy var lengthRuleLabel = createLabel(withTitle: "• Min length 8 characters.")
    private lazy var digitRuleLabel = createLabel(withTitle: "• Min 1 digit.")
    private lazy var lowercaseRuleLabel = createLabel(withTitle: "• Min 1 lowercase.")
    private lazy var uppercaseRuleLabel = createLabel(withTitle: "• Min 1 capital required.")
    
    private let validationProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = .clear
        progressView.setDimensions(height: 8)
        return progressView
    }()
    
    //MARK: - Properties
    
    lazy var lowestInterfaceElement: UIView = uppercaseRuleLabel
    private var textFields = [UITextField?]()
    
    //MARK: - Lifecycle
    
    init(viewModel: ValidationRulesViewModel = ValidationRulesViewModel()) {
        self.viewModel = viewModel
        super.init(textFieldPlaceholder: "Type here", leadingTitle: "Validation rules")
        configure()
        setAccessibilityIdentifiers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    private func configure() {
        inputTextField?.addTarget(self, action: #selector(inputLimitTextFieldDidChange), for: .editingChanged)
        inputTextField?.isSecureTextEntry = true
        let validationRulesStack = UIStackView(arrangedSubviews: [validationProgressView, lengthRuleLabel, digitRuleLabel, lowercaseRuleLabel, uppercaseRuleLabel])
        addSubview(validationRulesStack)
        validationRulesStack.axis = .vertical
        validationRulesStack.distribution = .fill
        validationRulesStack.spacing = 4
        validationRulesStack.anchor(top: inputTextField?.bottomAnchor, left: leftAnchor, right: rightAnchor)
    }
    
    private func setAccessibilityIdentifiers() {
        inputTextField?.accessibilityIdentifier = "validationRulesTextField"
        leftLabel?.accessibilityIdentifier = "validationRulesLeftLabel"
        lengthRuleLabel.accessibilityIdentifier = "lengthRuleLabel"
        digitRuleLabel.accessibilityIdentifier = "digitRuleLabel"
        lowercaseRuleLabel.accessibilityIdentifier = "lowercaseRuleLabel"
        uppercaseRuleLabel.accessibilityIdentifier = "uppercaseRuleLabel"
        validationProgressView.accessibilityIdentifier = "validationProgressView"
    }
    
    //MARK: - Selectors
    
    @objc private func inputLimitTextFieldDidChange() {
        guard let inputString = inputTextField?.text else { return }
        changeLabelIfCriteriaMet(viewModel.lengthCriteriaMet(inputString), label: lengthRuleLabel)
        changeLabelIfCriteriaMet(viewModel.digitMet(inputString), label: digitRuleLabel)
        changeLabelIfCriteriaMet(viewModel.lowercaseMet(inputString), label: lowercaseRuleLabel)
        changeLabelIfCriteriaMet(viewModel.uppercaseMet(inputString), label: uppercaseRuleLabel)
        validationProgressView.progress = viewModel.setBarProgress(input: inputString)
        setProgressBarColor(validationProgressView)
    }
    
    //MARK: - Helpers
    
    private func setProgressBarColor(_ progressBar: UIProgressView) {
        switch progressBar.progress {
        case 0..<0.25:
            progressBar.tintColor = .systemRed
        case 0.25..<0.5:
            progressBar.tintColor = .systemOrange
        case 0.5..<0.75:
            progressBar.tintColor = .systemYellow
        case 0.75...1:
            progressBar.tintColor = .systemGreen
        default:
            break
        }
    }
    
    private func changeLabelIfCriteriaMet(_ criteria: Bool, label: UILabel) {
        label.textColor = criteria ? .systemGreen : .black
        label.text = criteria ? label.text?.replacingOccurrences(of: "•", with: "✓") : label.text?.replacingOccurrences(of: "✓", with: "•")
    }
}
