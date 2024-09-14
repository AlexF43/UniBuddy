//
//  AssignmentsView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 14/9/2024.
//

import SwiftUI
import SwiftData

struct AssignmentsView: View {
    @Query private var subjects: [SubjectModel]
    @Environment(\.modelContext) private var modelContext
    @State private var editMode: EditMode = .inactive
    @State private var isAddingAssignment = false
    @State private var assignmentToEdit: AssignmentModel?
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Incomplete Assignments")) {
                    ForEach(incompleteAssignments) { assignment in
                        AssignmentRowView(assignment: assignment)
                    }
                    .onDelete(perform: deleteIncompleteAssignments)
                }
                
                Section(header: Text("Completed Assignments")) {
                    ForEach(completedAssignments) { assignment in
                        AssignmentRowView(assignment: assignment)
                    }
                    .onDelete(perform: deleteCompletedAssignments)
                }
            }
            .navigationTitle("All Assignments")
        }
    }
    
    
    private var incompleteAssignments: [AssignmentModel] {
        subjects.flatMap { $0.assignments }.filter { !$0.completed }.sorted { $0.dueDate < $1.dueDate }
    }
    
    private var completedAssignments: [AssignmentModel] {
        subjects.flatMap { $0.assignments }.filter { $0.completed }.sorted { $0.dueDate > $1.dueDate }
    }
    
    private func addAssignment(_ assignment: AssignmentModel) {
        modelContext.insert(assignment)
        try? modelContext.save()
    }
    
    private func deleteIncompleteAssignments(at offsets: IndexSet) {
        deleteAssignments(assignments: incompleteAssignments, at: offsets)
    }
    
    private func deleteCompletedAssignments(at offsets: IndexSet) {
        deleteAssignments(assignments: completedAssignments, at: offsets)
    }
    
    private func deleteAssignments(assignments: [AssignmentModel], at offsets: IndexSet) {
        for index in offsets {
            let assignmentToDelete = assignments[index]
            modelContext.delete(assignmentToDelete)
        }
        try? modelContext.save()
    }
}


