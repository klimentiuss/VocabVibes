//
//  String + Extension.swift
//  VocabVibes
//
//  Created by Daniil Klimenko on 12.06.2023.
//

import Foundation


extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self) could not find in Localizable.strings")
    }
}
