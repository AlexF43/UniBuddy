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
    var body: some View {
        VStack {
            if(!subject.assignments.isEmpty) {
                List {
                    // display the subjects incomplete assignments
                    if (!incompleteAssignments.isEmpty) {
                        Section(header: Text("Incomplete Assignments")) {
                            ForEach(incompleteAssignments) { assignment in
                                AssignmentRowView(assignment: assignment)
                            }
                            .onDelete(perform: deleteIncompleteAssignments)
                        }
                    }
                    
                    // display the subjects completed assignments
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
                // prompt the user to add assignments if there are none
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
            
            // show the sheet for adding assignments
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
    
    // filter the assignments and get just the incomplete ones
    private var incompleteAssignments: [AssignmentModel] {
        subject.assignments.filter { $0.completed == false }.sorted { $0.dueDate < $1.dueDate }
    }
    
    // filter the assignments and get just the completed ones
    private var completedAssignments: [AssignmentModel] {
        subject.assignments.filter { $0.completed != false }.sorted { $0.dueDate > $1.dueDate }
    }
    
    /// delete incomplete assigments using list functionality
    private func deleteIncompleteAssignments(at offsets: IndexSet) {
        viewModel.deleteAssignments(subject, assignments: incompleteAssignments, at: offsets, modelContext: modelContext)
    }
    
    /// delete complete assignments using list funcionality
    private func deleteCompletedAssignments(at offsets: IndexSet) {
        viewModel.deleteAssignments(subject, assignments: completedAssignments, at: offsets, modelContext: modelContext)
    }
}
