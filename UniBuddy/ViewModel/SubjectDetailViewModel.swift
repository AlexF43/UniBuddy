//
//  SubjectDetailViewModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import Foundation
import SwiftData

class SubjectDetailViewModel: ObservableObject {
    // controls the assignment subject sheet, true shows the sheet
    @Published var isAddingAssignment = false
    
    ///adds an assignment to swiftdata
    func addAssignment(_ subject: SubjectModel, _ assignment: AssignmentModel, modelContext: ModelContext) {
        subject.assignments.append(assignment)
        try? modelContext.save()
    }
    
    ///removes an assignment from swiftdata
    func deleteAssignments(_ subject: SubjectModel, assignments: [AssignmentModel], at offsets: IndexSet, modelContext: ModelContext) {
        // creates a list of assignments to be deleted
        let assignmentsToDelete = offsets.map { assignments[$0] }
            // iterates through the list and removes each assignment from swiftdata
        for assignment in assignmentsToDelete {
            if let index = subject.assignments.firstIndex(where: { $0.id == assignment.id }) {
                subject.assignments.remove(at: index)
            }
            modelContext.delete(assignment)
        }
        try? modelContext.save()
    }
}
