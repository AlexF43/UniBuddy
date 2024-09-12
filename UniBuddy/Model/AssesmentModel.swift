//
//  Item.swift
//  UniBuddy
//
//  Created by Alex Fogg on 11/9/2024.
//

import Foundation
import SwiftData

@Model
final class AssignmentModel {
    var taskName: String
    var taskDescription: String?
    var weighting: Float
    var dueDate: Date
    var grade: Float?
    
    init(taskName: String, taskDescription: String? = nil, weighting: Float, dueDate: Date, grade: Float? = nil) {
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.weighting = weighting
        self.dueDate = dueDate
        self.grade = grade
    }
    
    func dateDifferenceString() -> String {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.day], from: today, to: dueDate)
        
        guard let days = components.day else {
            return "Unknown due date"
        }
        
        switch days {
        case 0:
            return "Due today"
        case 1:
            return "Due tomorrow"
        case -1:
            return "Due yesterday"
        case 2...:
            return "Due in \(days) days"
        case ..<(-1):
            return "Due \(-days) days ago"
        default:
            return "Unknown due date"
        }
    }
}
