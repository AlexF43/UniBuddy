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
            if(!subject.assignments.isEmpty) {
                List {
                    if (!incompleteAssignments.isEmpty) {
                        Section(header: Text("Incomplete Assignments")) {
                            ForEach(incompleteAssignments) { assignment in
                                AssignmentRowView(assignment: assignment)
                            }
                            .onDelete(perform: deleteIncompleteAssignments)
                        }
                    }
                    
                    if (!completedAssignments.isEmpty) {
                        Section(header: Text("Completed Assignments")) {
                            ForEach(completedAssignments) { assignment in
                                AssignmentRowView(assignment: assignment)
                            }
                            .onDelete(perform: deleteCompletedAssignments)
                        }
                    }
                }
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("No Assignments?")
                        .font(.title)
                    Text("Try adding one using the button below to get started")
                        .font(.subheadline)
                    Spacer()
                    Spacer()
                }
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
        .navigationTitle(subject.subjectName)

        .sheet(isPresented: $viewModel.isAddingAssignment) {
            AddAssignmentView(isPresented: $viewModel.isAddingAssignment, onAdd: { newAssignment in
                viewModel.addAssignment(subject, newAssignment, modelContext: modelContext)
            })
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
