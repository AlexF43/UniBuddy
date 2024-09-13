//
//  SubjectDetailViewModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import Foundation
import SwiftData

class SubjectDetailViewModel: ObservableObject {
    @Published var isAddingAssignment = false
    
    func addAssignment(_ subject: SubjectModel, _ assignment: AssignmentModel, modelContext: ModelContext) {
        subject.assignments.append(assignment)
        try? modelContext.save()
    }
    
    func deleteAssignments(_ subject: SubjectModel, assignments: [AssignmentModel], at offsets: IndexSet, modelContext: ModelContext) {
        let assignmentsToDelete = offsets.map { assignments[$0] }
        for assignment in assignmentsToDelete {
            if let index = subject.assignments.firstIndex(where: { $0.id == assignment.id }) {
                subject.assignments.remove(at: index)
            }
            modelContext.delete(assignment)
        }
        try? modelContext.save()
    }
}
