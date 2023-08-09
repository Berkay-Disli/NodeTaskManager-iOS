//
//  TaskResponseModel.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import Foundation

struct TaskResponseModel: Codable {
    var id, userID, title, details: String
    var priority, status: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case title, details, priority, status
    }
}
