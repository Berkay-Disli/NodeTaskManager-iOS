//
//  Constants.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import Foundation

enum Constants {
    static let baseApi = "http://localhost:6000/"
    static let accessTokenKey = "AccessToken"
    // Auth
    static let REGISTER_URL_PATH = "users/register"
    static let LOGIN_URL_PATH = "users/login"
    static let CURRENT_USER_URL_PATH = "users/current"
    
    // Tasks
    static let MAIN_TASKS_URL_PATH = "tasks/"
}
