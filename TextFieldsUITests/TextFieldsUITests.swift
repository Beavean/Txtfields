//
//  TextFieldsUITests.swift
//  TextFieldsUITests
//
//  Created by Beavean on 15.11.2022.
//

import XCTest
@testable import TextFields

final class TextFieldsUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private lazy var titleLabel = app.staticTexts["titleLabel"]
    private lazy var showTabControllerButton = app.buttons["showTabControllerButton"]
    
    private lazy var noDigitsLeftLabel = app.staticTexts["noDigitsLeftLabel"]
    private lazy var noDigitsTextField = app.textFields["noDigitsTextField"]
    
    private lazy var inputLimitLeftLabel = app.staticTexts["inputLimitLeftLabel"]
    private lazy var inputLimitRightLabel = app.staticTexts["inputLimitRightLabel"]
    private lazy var inputLimitTextField = app.textFields["InputLimitTextField"]
    
    private lazy var onlyCharactersLeftLabel = app.staticTexts["onlyCharactersLeftLabel"]
    private lazy var onlyCharactersTextField = app.textFields["onlyCharactersTextField"]
    
    private lazy var linkLeftLabel = app.staticTexts["linkLeftLabel"]
    private lazy var linkTextField = app.textFields["linkTextField"]
    
    private lazy var validationRulesLeftLabel = app.staticTexts["validationRulesLeftLabel"]
    private lazy var validationRulesTextField = app.secureTextFields["validationRulesTextField"]
    private lazy var lengthRuleLabel = app.staticTexts["lengthRuleLabel"]
    private lazy var digitRuleLabel = app.staticTexts["digitRuleLabel"]
    private lazy var lowercaseRuleLabel = app.staticTexts["lowercaseRuleLabel"]
    private lazy var uppercaseRuleLabel = app.staticTexts["uppercaseRuleLabel"]
    
    private lazy var validationProgressView = app.progressIndicators["validationProgressView"]
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func test_interfaceElements() {
        XCTAssertTrue(titleLabel.exists)
        XCTAssertTrue(showTabControllerButton.exists)
        XCTAssertTrue(noDigitsLeftLabel.exists)
        XCTAssertTrue(noDigitsTextField.exists)
        XCTAssertTrue(inputLimitLeftLabel.exists)
        XCTAssertTrue(inputLimitRightLabel.exists)
        XCTAssertTrue(inputLimitTextField.exists)
        XCTAssertTrue(onlyCharactersLeftLabel.exists)
        XCTAssertTrue(onlyCharactersTextField.exists)
        XCTAssertTrue(linkLeftLabel.exists)
        XCTAssertTrue(linkTextField.exists)
        XCTAssertTrue(validationRulesLeftLabel.exists)
        XCTAssertTrue(validationRulesTextField.exists)
        XCTAssertTrue(lengthRuleLabel.exists)
        XCTAssertTrue(digitRuleLabel.exists)
        XCTAssertTrue(lowercaseRuleLabel.exists)
        XCTAssertTrue(uppercaseRuleLabel.exists)
        XCTAssertTrue(validationProgressView.exists)
    }
    
    func test_keyboardDismissal() {
        noDigitsTextField.tap()
        noDigitsTextField.typeText("123qwe")
        noDigitsLeftLabel.tap()
        XCTAssertTrue(app.keyboards.count == 0)
    }
    
    func test_noDigitsTextField() {
        noDigitsTextField.tap()
        noDigitsTextField.typeText("!1q2w3e4r@")
        XCTAssertEqual(noDigitsTextField.value as? String, "!qwer@")
    }
    
    func test_inputLimitTextField() {
        inputLimitTextField.tap()
        inputLimitTextField.typeText("123456789qw")
        XCTAssertEqual(inputLimitRightLabel.label, "11/10")
    }
    
    func test_onlyCharactersTextField() {
        onlyCharactersTextField.tap()
        onlyCharactersTextField.typeText("Q123w!@#E456r$%^T678y^&*U901i!@#O123")
        XCTAssertEqual(onlyCharactersTextField.value as? String, "QwErT-78901")
    }
    
    func test_linkTextFieldNoLinkInput() {
        linkTextField.tap()
        linkTextField.typeText("noLink")
        XCTAssertFalse(app.buttons["ReloadButton"].waitForExistence(timeout: 10))
    }
    
    func test_linkTextFieldLinkInput() {
        linkTextField.tap()
        linkTextField.typeText("https://apple.com")
        XCTAssertTrue(app.buttons["ReloadButton"].waitForExistence(timeout: 10))
    }
    
    func test_passwordTextProgressBar() {
        let maxProgress = "100 %"
        validationRulesTextField.tap()
        validationRulesTextField.typeText("1qQ45678Qa")
        XCTAssertEqual(validationProgressView.value as? String, maxProgress)
    }
}
