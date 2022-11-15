//
//  ValidationRulesViewModel.swift
//  TextFields
//
//  Created by Beavean on 31.10.2022.
//

import Foundation

final class ValidationRulesViewModel {
    
    let lengthCriteria = 8
    private let uppercaseRegexCriteria = "[A-Z]+"
    private let lowercaseRegexCriteria = "[a-z]+"
    private let digitRegexCriteria = "[0-9]+"
    
    func lengthCriteriaMet(_ text: String) -> Bool {
        text.count >= lengthCriteria
    }
    
    func uppercaseMet(_ text: String) -> Bool {
        text.range(of: uppercaseRegexCriteria, options: .regularExpression) != nil
    }
    
    func lowercaseMet(_ text: String) -> Bool {
        text.range(of: lowercaseRegexCriteria, options: .regularExpression) != nil
    }
    
    func digitMet(_ text: String) -> Bool {
        text.range(of: digitRegexCriteria, options: .regularExpression) != nil
    }
    
    func setBarProgress(input: String) -> Float {
        var progress: Float = 0
        progress += lengthCriteriaMet(input) ? 0.25 : 0
        progress += uppercaseMet(input) ? 0.25 : 0
        progress += lowercaseMet(input) ? 0.25 : 0
        progress += digitMet(input) ? 0.25 : 0
        return progress
    }
}
