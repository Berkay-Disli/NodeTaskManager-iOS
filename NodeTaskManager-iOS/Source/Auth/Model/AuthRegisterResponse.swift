//
//  AuthRegisterResponse.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import Foundation

struct AuthRegisterResponse: Codable {
    var id: String
    var email: String
}

struct AuthCurrentUserResponse: Codable {
    var id: String
    var email: String
    var username: String
}

struct AuthLoginResponse: Codable {
    let accessToken: String
}
