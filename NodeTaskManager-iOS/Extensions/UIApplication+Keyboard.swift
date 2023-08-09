//
//  UIApplication+Keyboard.swift
//  Abonesepeti
//
//  Created by Marjan on 11/13/1400 AP.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
