//
//  TaskRequestModel.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 10.08.2023.
//

import Foundation

struct TaskRequestModel: Codable {
    var title, details: String
    var priority, status: String
}
