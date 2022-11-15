//
//  TextFieldsUnitTests.swift
//  TextFieldsUnitTests
//
//  Created by Beavean on 10.11.2022.
//

import XCTest
@testable import TextFields

final class TextFieldsUnitTests: XCTestCase {
    
    private var noDigitsSut: NoDigitsViewModel!
    private var inputLimitSut: InputLimitViewModel!
    private var onlyCharactersSut: OnlyCharactersViewModel!
    private var linkSut: LinkViewModel!
    private var validationRulesSut: ValidationRulesViewModel!
    
    override func setUp() {
        super.setUp()
        noDigitsSut = NoDigitsViewModel()
        inputLimitSut = InputLimitViewModel()
        onlyCharactersSut = OnlyCharactersViewModel()
        linkSut = LinkViewModel()
        validationRulesSut = ValidationRulesViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        noDigitsSut = nil
        inputLimitSut = nil
        onlyCharactersSut = nil
        linkSut = nil
        validationRulesSut = nil
    }
    
    //MARK: - No Digits model tests
    
    func test_NoDigits_emptyString() {
        XCTAssertEqual(noDigitsSut.removeDigits(fromString: ""), "")
    }
    
    func test_NoDigits_numbersString() {
        XCTAssertEqual(noDigitsSut.removeDigits(fromString: "12345"), "")
    }
    
    func test_NoDigits_lettersString() {
        XCTAssertEqual(noDigitsSut.removeDigits(fromString: "qwerty"), "qwerty")
    }
    
    func test_NoDigits_symbolsString() {
        XCTAssertEqual(noDigitsSut.removeDigits(fromString: "!@#$%"), "!@#$%")
    }
    
    func test_NoDigits_mixedString() {
        XCTAssertEqual(noDigitsSut.removeDigits(fromString: "qwerty12345!@#$%"), "qwerty!@#$%")
    }
    
    //MARK: - Input Limit model tests
    
    func test_inputLimit_emptyString() {
        XCTAssertNotNil(inputLimitSut.createOutputAndCheckLimit(fromString: ""))
    }
    
    func test_inputLimit_underLimitString() {
        let inputString = String(repeating: "0", count: inputLimitSut.inputLimit - 1)
        let limitIndicator =  NSAttributedString(string: "\(inputLimitSut.inputLimit - 1)/\(inputLimitSut.inputLimit)")
        XCTAssertEqual(inputLimitSut.indicateLimit(fromString: inputString)?.string, limitIndicator.string)
        XCTAssertFalse(inputLimitSut.checkInputForLimit(fromString: inputString))
    }
    
    func test_inputLimit_overLimitString() {
        let inputString = String(repeating: "0", count: inputLimitSut.inputLimit + 1)
        let limitIndicator =  NSAttributedString(string: "\(inputLimitSut.inputLimit + 1)/\(inputLimitSut.inputLimit)")
        XCTAssertEqual(inputLimitSut.indicateLimit(fromString: inputString)?.string, limitIndicator.string)
        XCTAssertTrue(inputLimitSut.checkInputForLimit(fromString: inputString))
    }
    
    
    //MARK: - Only Characters model tests
    
    func test_onlyCharacters_emptyString() {
        XCTAssertNotNil(onlyCharactersSut.formatInput(fromString: ""))
    }
    
    func test_onlyCharacters_mixedString() {
        XCTAssertEqual(onlyCharactersSut.formatInput(fromString: "12345qwerty!@#$%^12345qwerty"), "qwert-12345")
    }
    
    //MARK: - Link model tests
    
    func test_link_verifyNotLinkInput() {
        XCTAssertFalse(linkSut.verifyLinkInput(fromString: "htt://notlink"))
    }
    
    func test_link_verifyLinkInput() {
        XCTAssertTrue(linkSut.verifyLinkInput(fromString: "http://link.com"))
    }
    
    func test_link_createUrlFromNotLinkInput() {
        XCTAssertNil(linkSut.getUrl(fromString: "htt://notlink"))
    }
    
    func test_link_createUrlFromLinkInput() {
        XCTAssertEqual(linkSut.getUrl(fromString: "http://link.com"), URL(string:"http://link.com"))
    }
    
    //MARK: - Validation rules model tests
    
    func test_validationRules_lengthCriteriaNotMet() {
        let inputString = String(repeating: "0", count: validationRulesSut.lengthCriteria - 1)
        XCTAssertFalse(validationRulesSut.lengthCriteriaMet(inputString))
    }
    
    func test_validationRules_lengthCriteriaMet() {
        let inputString = String(repeating: "0", count: validationRulesSut.lengthCriteria)
        XCTAssertTrue(validationRulesSut.lengthCriteriaMet(inputString))
    }
    
    func test_validationRules_uppercaseCriteriaNotMet() {
        XCTAssertFalse(validationRulesSut.uppercaseMet("qwer1234"))
    }
    
    func test_validationRules_uppercaseCriteriaMet() {
        XCTAssertTrue(validationRulesSut.uppercaseMet("Q"))
    }
    
    func test_validationRules_LowercaseNotMet() {
        XCTAssertFalse(validationRulesSut.lowercaseMet("QWER1234"))
    }
    
    func test_validationRules_LowercaseCriteriaMet() {
        XCTAssertTrue(validationRulesSut.lowercaseMet("q"))
    }
    
    func test_validationRules_digitCriteriaNotMet() {
        XCTAssertFalse(validationRulesSut.digitMet("QWERqwer"))
    }
    
    func test_validationRules_digitCriteriaMet() {
        XCTAssertTrue(validationRulesSut.digitMet("1"))
    }
    
    func test_ValidationRules_progressBarSetter() {
        XCTAssertEqual(validationRulesSut.setBarProgress(input: "a"), 0.25)
        XCTAssertEqual(validationRulesSut.setBarProgress(input: "aA"), 0.5)
        XCTAssertEqual(validationRulesSut.setBarProgress(input: "aA12345"), 0.75)
        XCTAssertEqual(validationRulesSut.setBarProgress(input: "aA12345!"), 1.0)
    }
}
    
