//
//  TaskPriorityModel.swift
//  NodeTaskManager-iOS
//
//  Created by Berkay Dişli on 10.08.2023.
//

import Foundation
import SwiftUI

enum TaskPriorityModel: String, CaseIterable {
    case low, medium, done
    var id: Self { self }
    
    var title: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .done:
            return "High"
        }
    }
    
    var color: Color {
        switch self {
        case .low:
            return .green
        case .medium:
            return .yellow
        case .done:
            return .red 
        }
    }
}
