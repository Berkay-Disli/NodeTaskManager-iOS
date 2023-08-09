//
//  CGFloat+Random.swift
//  Abonesepeti
//
//  Created by Marjan on 12/12/1400 AP.
//

import CoreGraphics

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
