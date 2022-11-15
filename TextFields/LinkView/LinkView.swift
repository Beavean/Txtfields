//
//  LinkView.swift
//  TextFields
//
//  Created by Beavean on 31.10.2022.
//

import UIKit
import SafariServices

final class LinkView: TextFieldSectionView {
    
    private let viewModel: LinkViewModel
    private var linkTextFieldTimer: Timer?
    
    init(viewModel: LinkViewModel = LinkViewModel()) {
        self.viewModel = viewModel
        super.init(textFieldPlaceholder: "Type here", leadingTitle: "Link")
        inputTextField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        setAccessibilityIdentifiers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAccessibilityIdentifiers() {
        inputTextField?.accessibilityIdentifier = "linkTextField"
        leftLabel?.accessibilityIdentifier = "linkLeftLabel"
    }
    
    private func openUrlInSafari(_ openingUrl: URL) {
        let safariVC = SFSafariViewController(url: openingUrl)
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(safariVC, animated: true, completion: nil)
        }
    }
    
    @objc private func textFieldDidChange() {
        let inputString = inputTextField?.text
        if viewModel.verifyLinkInput(fromString: inputString) {
            inputTextField?.showRedBorder(false)
            inputTextField?.showBlueBorder(true)
            linkTextFieldTimer?.invalidate()
            linkTextFieldTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
                guard let openingUrl = self?.viewModel.getUrl(fromString: inputString) else { return }
                self?.openUrlInSafari(openingUrl)
            }
        } else {
            inputString?.isEmpty == false ? inputTextField?.showRedBorder(true) : inputTextField?.showBlueBorder(true)
        }
    }
}
