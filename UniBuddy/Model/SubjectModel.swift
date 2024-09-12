//
//  SubjectModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 11/9/2024.
//

import Foundation
import SwiftData

@Model
final class SubjectModel {
    var subjectName: String
    var creditPoints: Int
    var assignments: [AssignmentModel]
    
    init(subjectName: String, creditPoints: Int, assignments: [AssignmentModel]) {
        self.subjectName = subjectName
        self.creditPoints = creditPoints
        self.assignments = assignments
    }
    
    
    func calculateSubjectGrade() -> Float {
        let gradedAssignments = assignments.filter { $0.grade != nil }
        
        guard !gradedAssignments.isEmpty else {
            return 0
        }
        
        var totalWeightCompleted: Float = 0.0
        var totalGrade: Float = 0.0
        
        for assignment in gradedAssignments {
            totalWeightCompleted += assignment.weighting
            
            if let grade = assignment.grade {
                totalGrade += grade
            }
        }
        
        if totalWeightCompleted > 100 {
            totalWeightCompleted = 100
        }
        
        if totalGrade > 100 {
            totalGrade = 100
        }
        
        return totalGrade/totalWeightCompleted
    }
    
    /// returns the integer number of days until the next assignment is due
    /// used for sorting the subjects by what is due next
    func daysUntilNextAssignment() -> Int? {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // filters out assignments in the past
        let upcomingAssignments = assignments.filter { $0.dueDate > currentDate }
        
        // sorts the assignments leaving the closest one in first place
        let sortedAssignments = upcomingAssignments.sorted { $0.dueDate < $1.dueDate }
        
        // getting the next assignent if it exists
        guard let nextAssignment = sortedAssignments.first else {
            return nil
        }
        
        // returns the number of days between now and the due date of the next assignment
        let components = calendar.dateComponents([.day], from: currentDate, to: nextAssignment.dueDate)
        return components.day
    }
    
    func daysUntilNextAssignmentString() -> String {
        let daysUntilNextAssignment = daysUntilNextAssignment()
        
        guard let days = daysUntilNextAssignment else {
            return "No upcoming assignments"
        }
        
        switch days {
        case 0:
            return "today"
        case 1...:
            return "in (\(days) days)"
        default:
            return "No upcoming assignments"
        }
    }
}
