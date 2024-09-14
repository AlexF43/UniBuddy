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
        .navigationBarItems(
            leading: EditButton(),
            trailing: addButton
        )
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $viewModel.isAddingAssignment) {
            AddAssignmentView(isPresented: $viewModel.isAddingAssignment, onAdd: { newAssignment in
                viewModel.addAssignment(subject, newAssignment, modelContext: modelContext)
            })
        }
//        .sheet(item: $assignmentToEdit) { assignment in
//            EditAssignmentView(assignment: assignment, isPresented: Binding(
//                get: { assignmentToEdit != nil },
//                set: { if !$0 { assignmentToEdit = nil } }
//            ))
//        }
    }
    
    private var addButton: some View {
        Button(action: {
            viewModel.isAddingAssignment = true
        }) {
            Image(systemName: "plus")
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
