//
//  HomeViewModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import SwiftUI
import SwiftData

class HomeViewModel: ObservableObject {
    // controls the add subject sheet, true shows the sheet
    @Published var isAddingSubject = false
    
    /// add a subject to swiftdata
    func addSubject(_ subject: SubjectModel, modelContext: ModelContext) {
        modelContext.insert(subject)
    }
    
    /// Seed swiftdata with example data
    func seedExampleData(modelContext: ModelContext) {
        //create a date formatter and set it to a format which can be entered as a string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        
        // creating the example subjects and assignments
        let adnet = SubjectModel(subjectName: ".Net Development", creditPoints: 6, assignments: [
            AssignmentModel(taskName: "Quiz 1", weighting: 5, dueDate: dateFormatter.date(from: "2024-08-14") ?? Date(), completed: true, grade: 80),
            AssignmentModel(taskName: "Quiz 2", weighting: 5, dueDate: dateFormatter.date(from: "2024-08-28") ?? Date(), completed: true, grade: 70),
            AssignmentModel(taskName: "Quiz 3", weighting: 5, dueDate: dateFormatter.date(from: "2024-09-11") ?? Date(), completed: true),
            AssignmentModel(taskName: "VS console application", weighting: 35, dueDate: dateFormatter.date(from: "2024-09-23") ?? Date(), completed: false),
            AssignmentModel(taskName: "Quiz 4", weighting: 5, dueDate: dateFormatter.date(from: "2024-10-09") ?? Date(), completed: false)
        ])

        let aiosd = SubjectModel(subjectName: "Advanced iOS", creditPoints: 6, assignments: [
            AssignmentModel(taskName: "Solution Pitch Evaluation", weighting: 10, dueDate: dateFormatter.date(from: "2024-08-23") ?? Date(), completed: true),
            AssignmentModel(taskName: "Project 1", weighting: 30, dueDate: dateFormatter.date(from: "2024-09-15") ?? Date(), completed: false),
            AssignmentModel(taskName: "Project 2", weighting: 30, dueDate: dateFormatter.date(from: "2024-10-11") ?? Date(), completed: false)
        ])

        let ppp = SubjectModel(subjectName: "Professional Practice", creditPoints: 3, assignments: [
            AssignmentModel(taskName: "Reflective Learning Journal Part A", weighting: 0, dueDate: dateFormatter.date(from: "2024-08-26") ?? Date(), completed: true, grade: 100),
            AssignmentModel(taskName: "Competitive Professional Engineering", weighting: 50, dueDate: dateFormatter.date(from: "2024-09-02") ?? Date(), completed: true, grade: 100),
            AssignmentModel(taskName: "Reflective Learning Journal Part B", weighting: 50, dueDate: dateFormatter.date(from: "2024-09-09") ?? Date(), completed: true)
        ])

        let pm = SubjectModel(subjectName: "Project Management", creditPoints: 6, assignments: [
            AssignmentModel(taskName: "Online Assignment 1", weighting: 8.75, dueDate: dateFormatter.date(from: "2024-08-30") ?? Date(), completed: true, grade: 100),
            AssignmentModel(taskName: "Online Assignment 2", weighting: 8.75, dueDate: dateFormatter.date(from: "2024-09-20") ?? Date(), completed: true),
            AssignmentModel(taskName: "Online Assignment 3", weighting: 8.75, dueDate: dateFormatter.date(from: "2024-10-11") ?? Date(), completed: false)
        ])

        let epa = SubjectModel(subjectName: "EPA", creditPoints: 6, assignments: [
            AssignmentModel(taskName: "Project Evauation", weighting: 30, dueDate: dateFormatter.date(from: "2024-09-15") ?? Date(), completed: false)
        ])
        
        // adding the example subjects to swiftdata storage
        modelContext.insert(adnet)
        modelContext.insert(aiosd)
        modelContext.insert(ppp)
        modelContext.insert(pm)
        modelContext.insert(epa)

    }
}

