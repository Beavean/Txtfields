//
//  SingleTextFieldViewController.swift
//  TextFields
//
//  Created by Beavean on 31.10.2022.
//

import UIKit

final class SingleTextFieldViewController: TextInputViewController {
    
    //MARK: - UI Elements & Properties 
    
    private let textFieldView: TextFieldSectionView
    private let defaultPadding: CGFloat = 16
    
    //MARK: - Lifecycle
    
    init(textFieldView: TextFieldSectionView) {
        self.textFieldView = textFieldView
        super.init(nibName: nil, bundle: nil)
        self.title = textFieldView.leftLabel?.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(textFieldView)
        textFieldView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: defaultPadding, paddingLeft: defaultPadding, paddingRight: defaultPadding)
        textFieldView.inputTextField?.returnKeyType = .done
        textFieldView.inputTextField?.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
