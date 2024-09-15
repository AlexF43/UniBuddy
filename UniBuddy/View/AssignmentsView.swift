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
    
    var body: some View {
        NavigationStack {
            // list displaying all completed and incomplete assignments in seperate sections
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
    
    // get all incompleted assignments, filtered by closest dude date at the top
    private var incompleteAssignments: [AssignmentModel] {
        subjects.flatMap { $0.assignments }.filter { !$0.completed }.sorted { $0.dueDate < $1.dueDate }
    }
    
    // get all completed assignments, filtered by closest dude date at the top
    private var completedAssignments: [AssignmentModel] {
        subjects.flatMap { $0.assignments }.filter { $0.completed }.sorted { $0.dueDate > $1.dueDate }
    }
    
    /// delete incomplete assignments using default list delete
    private func deleteIncompleteAssignments(at offsets: IndexSet) {
        deleteAssignments(assignments: incompleteAssignments, at: offsets)
    }
    
    /// delete completed assignments using default list delete
    private func deleteCompletedAssignments(at offsets: IndexSet) {
        deleteAssignments(assignments: completedAssignments, at: offsets)
    }
    
    /// delete an assignment based off its index
    private func deleteAssignments(assignments: [AssignmentModel], at offsets: IndexSet) {
        for index in offsets {
            let assignmentToDelete = assignments[index]
            modelContext.delete(assignmentToDelete)
        }
        try? modelContext.save()
    }
}


