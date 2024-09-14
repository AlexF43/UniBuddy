//
//  SubjectDetailView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import SwiftUI
import SwiftData

struct SubjectDetailView: View {
    @Bindable var subject: SubjectModel
    @StateObject private var viewModel = SubjectDetailViewModel()
    @Environment(\.modelContext) private var modelContext
    @State private var editMode: EditMode = .inactive
    @State private var assignmentToEdit: AssignmentModel?
    
    var body: some View {
        VStack {
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
            .navigationTitle(subject.subjectName)

            .sheet(isPresented: $viewModel.isAddingAssignment) {
                AddAssignmentView(isPresented: $viewModel.isAddingAssignment, onAdd: { newAssignment in
                    viewModel.addAssignment(subject, newAssignment, modelContext: modelContext)
                })
            }
            Button(action: {
                viewModel.isAddingAssignment = true
            }) {
                Text("Add assignment")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }

    }
    
    
    private var incompleteAssignments: [AssignmentModel] {
        subject.assignments.filter { $0.completed == false }.sorted { $0.dueDate < $1.dueDate }
    }
    
    private var completedAssignments: [AssignmentModel] {
        subject.assignments.filter { $0.completed != false }.sorted { $0.dueDate > $1.dueDate }
    }
    
    private func deleteIncompleteAssignments(at offsets: IndexSet) {
        viewModel.deleteAssignments(subject, assignments: incompleteAssignments, at: offsets, modelContext: modelContext)
    }
    
    private func deleteCompletedAssignments(at offsets: IndexSet) {
        viewModel.deleteAssignments(subject, assignments: completedAssignments, at: offsets, modelContext: modelContext)
    }
}
