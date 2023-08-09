//
//  View+AnyView.swift
//  Abonesepeti
//
//  Created by Marjan on 10/9/1400 AP.
//

import SwiftUI

extension View {
    func toAnyView() -> AnyView {
        return AnyView(self)
    }
}
