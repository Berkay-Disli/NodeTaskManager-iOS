//
//  AuthRequest.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import Foundation

struct AuthLoginRequest: Codable {
    var email: String
    var password: String
}
