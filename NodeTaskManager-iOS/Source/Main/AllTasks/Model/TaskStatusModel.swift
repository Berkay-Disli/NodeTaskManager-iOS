//
//  TaskStatusModel.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 9.08.2023.
//

import Foundation

enum TaskStatusModel: String, CaseIterable {
    case todo, inProgress, done
    
    enum CodingKeys: String, CodingKey {
        case inProgress = "in-progress"
    }
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .todo:
            return "To Do"
        case .inProgress:
            return "In Progress"
        case .done:
            return "Done"
        }
    }
    
    var serviceTitle: String {
        switch self {
        case .todo:
            return "todo"
        case .inProgress:
            return "in-progress"
        case .done:
            return "done"
        }
    }
}
