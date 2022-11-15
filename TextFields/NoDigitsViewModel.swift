//
//  NoDigitsViewModel.swift
//  TextFields
//
//  Created by Beavean on 30.10.2022.
//

import Foundation

final class NoDigitsViewModel {
    
    private let removedElements = CharacterSet.decimalDigits
    
    func removeDigits(fromString string: String?) -> String? {
        guard let string else { return nil }
        return string.components(separatedBy: removedElements).joined()
    }
}
