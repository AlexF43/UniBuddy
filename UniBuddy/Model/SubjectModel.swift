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
    var assignments: [AssignmentModel] = []
    
    init(subjectName: String, creditPoints: Int, assignments: [AssignmentModel] = []) {
        self.subjectName = subjectName
        self.creditPoints = creditPoints
        self.assignments = assignments
    }
    
    func updateAssignment(_ assignment: AssignmentModel) {
        if let index = assignments.firstIndex(where: { $0.id == assignment.id }) {
            assignments[index] = assignment
        }
    }
    
    func calculateCompletion() -> Float {
        let completedAssignments = assignments.filter { $0.completed == true }
        
        guard !completedAssignments.isEmpty else {
            return 0
        }
        
        var totalWeightCompleted: Float = 0.0
        
        for assignment in completedAssignments {
            totalWeightCompleted += assignment.weighting
        }
        return min(totalWeightCompleted/100, 1.0)
    }
    
    func calculateMarkOfCompleted() -> Float {
        let gradedAssignments = assignments.filter { $0.grade != nil }
        
        guard !gradedAssignments.isEmpty else {
            return 0
        }
        
        var totalGrade: Float = 0.0
        
        for assignment in gradedAssignments {
            
            if let grade = assignment.grade {
                totalGrade += grade*assignment.weighting/100
            }
        }
        
        return min(totalGrade/100, 1.0)
    }
    
    func calculatePredictedGrade() -> Float {
        let completion = calculateCompletion()
        let markOfCompleted = calculateMarkOfCompleted()
        
        guard completion > 0 else {
            print("Cannot calculate predicted grade: No assignments completed.")
            return 0
        }
        
        return markOfCompleted / completion
    }
    
    /// returns the integer number of days until the next assignment is due
    /// used for sorting the subjects by what is due next
    func daysUntilNextAssignment() -> Int? {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date())
        
        // filters out assignments in the past
        let incompleteAssignments = assignments.filter { $0.completed == false }
        
        // sorts the assignments leaving the closest one in first place
        let sortedAssignments = incompleteAssignments.sorted { $0.dueDate < $1.dueDate }
        
        // getting the next assignent if it exists
        guard let nextAssignment = sortedAssignments.first else {
            return nil
        }
        
        let startOfDueDate = calendar.startOfDay(for: nextAssignment.dueDate)
        
        // returns the number of days between now and the due date of the next assignment
        let components = calendar.dateComponents([.day], from: currentDate, to: startOfDueDate)
        return components.day
    }
    
    func daysUntilNextAssignmentString() -> String {
        let daysUntilNextAssignment = daysUntilNextAssignment()
        
        guard let days = daysUntilNextAssignment else {
            return "No upcoming assignments"
        }
        
        switch days {
        case ..<(-1):
            return "Overdue assignment by \(days*(-1)) days"
        case 0:
            return "Next assignment due today"
        case 1:
            return "Next assignment due tomorrow"
        case 2...:
            return "Next assignment due in \(days) days"
        default:
            return "No upcoming assignments"
        }
    }
}
