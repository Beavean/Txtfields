//
//  InputLimitViewModel.swift
//  TextFields
//
//  Created by Beavean on 30.10.2022.
//

import UIKit

final class InputLimitViewModel {
    
    let inputLimit = 10

    func createOutputAndCheckLimit(fromString string: String?) -> NSMutableAttributedString? {
        guard let string else { return nil }
        let attributedString = NSMutableAttributedString(string: string)
        if string.count > inputLimit {
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: string.count))
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: inputLimit, length: string.count - inputLimit))
        } else {
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: string.count))
        }
        return attributedString
    }
    
    func indicateLimit(fromString string: String?) -> NSMutableAttributedString? {
        guard let string else { return nil }
        let labelText = "\(string.count)/\(inputLimit)"
        let attributedString = NSMutableAttributedString(string: labelText)
        if string.count > inputLimit {
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: labelText.count))
        }
        return attributedString
    }
    
    func checkInputForLimit(fromString string: String?) -> Bool {
        return (string?.count ?? 0) > inputLimit
    }
}
