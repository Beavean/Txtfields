//
//  LinkViewModel.swift
//  TextFields
//
//  Created by Beavean on 31.10.2022.
//

import UIKit

final class LinkViewModel {
    
    func verifyLinkInput(fromString string: String?) -> Bool {
        guard let string,
              let url = NSURL(string: string),
              string.lowercased().hasPrefix("http"),
              string.contains(".")
        else { return false }
        return UIApplication.shared.canOpenURL(url as URL)
    }
    
    func getUrl(fromString string: String?) -> URL? {
        guard let string,
              let openingUrl = URL(string: string),
              string.lowercased().hasPrefix("http"),
              string.contains(".")
        else { return nil }
        return openingUrl
    }
}
