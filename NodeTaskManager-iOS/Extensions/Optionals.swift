//
//  Optionals.swift
//  Abonesepeti
//
//  Created by Marjan on 8/3/1400 AP.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        guard let string = self else { return true }
        return string.isEmpty
    }
}
