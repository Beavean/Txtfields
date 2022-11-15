//
//  OnlyCharactersViewModel.swift
//  TextFields
//
//  Created by Beavean on 31.10.2022.
//

import Foundation

final class OnlyCharactersViewModel {
    
    private let charactersLimit = 11
    private let separatorLocation = 6
    private let separator = "-"
    private let firstRange = "[a-zA-Z]"
    private let secondRange = "[0-9]+"
    
    func formatInput(fromString string: String?) -> String {
        guard let string else { return "" }
        var resultString = String()
        for character in string {
            let characterAsString = String(character)
            switch resultString.count {
            case 0...separatorLocation - 2:
                resultString += characterAsString.range(of: firstRange, options: .regularExpression) != nil ? characterAsString : ""
            case separatorLocation - 1:
                resultString += separator
            case separatorLocation...charactersLimit - 1:
                resultString += characterAsString.range(of: secondRange, options: .regularExpression) != nil ? characterAsString : ""
            default:
                break
            }
        }
        return resultString
    }
}
