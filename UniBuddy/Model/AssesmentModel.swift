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
    var weighting: Float
    var dueDate: Date
    var completed: Bool
    var grade: Float?
    @Relationship(inverse: \SubjectModel.assignments) var subject: SubjectModel?
    
    init(taskName: String, weighting: Float, dueDate: Date, completed: Bool ,grade: Float? = nil) {
        self.taskName = taskName
        self.weighting = weighting
        self.dueDate = dueDate
        self.completed = completed
        self.grade = grade
    }
    
    /// Returns a user readable string of the number of days to/past the assignments due dats
    func dateDifferenceString() -> String {
        
        //gets the datetime of the begining of the current day and the begining of the due date
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dueDateStart = calendar.startOfDay(for: dueDate)
        
        //calculating the number of days between today and the due date
        let components = calendar.dateComponents([.day], from: today, to: dueDateStart)
        
        //attempts to convert the date component number of days to an integer number of days
        guard let days = components.day else {
            return "Unknown due date"
        }
        
        //returns the appropriate message to the user depending on the number of days to/past the due date
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
