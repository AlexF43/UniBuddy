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
    
    /// calculates the amount of the subject that has been completed as a float between 0 and 1
    func calculateCompletion() -> Float {
        //filters all the assignments by if they have been completed ir not
        let completedAssignments = assignments.filter { $0.completed == true }
        
        //if there are no completed assignments return 0
        guard !completedAssignments.isEmpty else {
            print("No completed assignments")
            return 0
        }
        
        var totalWeightCompleted: Float = 0.0
        
        // adds all the weights of assignments that have been completed to a running total
        for assignment in completedAssignments {
            totalWeightCompleted += assignment.weighting
        }
        
        // converts the weight completed out of 100 to a decimal between 0 and 1.
        // if the weight is above 1 return 1
        return min(totalWeightCompleted/100, 1.0)
    }
    
    /// calculates the amount of a subject that has been marked
    func calculateWeightOfMarked() -> Float {
        //filters the assignments by those that have been graded
        let gradedAssignments = assignments.filter { $0.grade != nil }
        
        //return 0 if there are no graded assignments
        guard !gradedAssignments.isEmpty else {
            print("No assignments have been graded, cannot get amount graded")
            return 0
        }
        
        var totalWeight: Float = 0.0
        
        //add each assignments weight to the running total
        for assignment in gradedAssignments {
            totalWeight += assignment.weighting
        }
        
        // converts the weight completed out of 100 to a decimal between 0 and 1.
        // if the weight is above 1 return 1
        return min(totalWeight/100, 1.0)
    }
    
    /// calculates a total of all marks recieved
    func calculateMarkOfCompleted() -> Float {
        //filters the assignments by only those which are graded
        let gradedAssignments = assignments.filter { $0.grade != nil }
        
        //if there are no graded assignments return 0
        guard !gradedAssignments.isEmpty else {
            print("No Assignments Completed")
            return 0
        }
        
        var totalGrade: Float = 0.0
        
        //add each mark on a running total of the marks
        for assignment in gradedAssignments {
            if let grade = assignment.grade {
                totalGrade += grade*assignment.weighting/100
            }
        }
        
        // converts the grade out of 100 to a decimal between 0 and 1.
        // if the weight is above 1 return 1
        return min(totalGrade/100, 1.0)
    }
    
    ///calculates the preducted grade for the subject
    func calculatePredictedGrade() -> Float {
        // get the amount of the subject marked and the total mark recieved
        let completion = calculateWeightOfMarked()
        let markOfCompleted = calculateMarkOfCompleted()
        
        // if no assignments are completed then return 0 to prevent divide by zero error
        guard completion >= 0 else {
            print("Cannot calculate predicted grade: No assignments completed.")
            return 0
        }
        
        //returns a decimal bwteen 0 and 1 of the predicted grade
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
            print("No Upcoming Assignment")
            return nil
        }
        
        let startOfDueDate = calendar.startOfDay(for: nextAssignment.dueDate)
        
        // returns the number of days between now and the due date of the next assignment
        let components = calendar.dateComponents([.day], from: currentDate, to: startOfDueDate)
        return components.day
    }
    
    /// Returns a user readable string of the number of days to/past the closest unmarked assignments due date
    func daysUntilNextAssignmentString() -> String {
        let daysUntilNextAssignment = daysUntilNextAssignment()
        
        //if check if there is an upcoming assignment
        guard let days = daysUntilNextAssignment else {
            return "No upcoming assignments"
        }
        
        //returns the appropriate message to the user depending on the number of days to/past the due date
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
