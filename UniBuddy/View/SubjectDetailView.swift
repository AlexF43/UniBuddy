//
//  SubjectDetailView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import SwiftUI

struct SubjectDetailView: View {
    @StateObject private var subjectViewModel = SubjectDetailViewModel()
    @Environment(\.modelContext) private var modelContext
    var subject: SubjectModel
    
    var body: some View {
        VStack {
            Text("Predicted Grade: \(subject.calculateSubjectGrade())")
            
            HStack {
                Text("Assignments")
                Button(action: {
                    subjectViewModel.isAddingAssignment = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
                
            }
            List {
                ForEach(subject.assignments) { assignment in
                    NavigationLink(destination: AssignmentDetailView(assignment: assignment)) {
                        VStack(alignment: .leading) {
                            AssignmnetRowView(assignment: assignment)
                        }
                    }
                }
                .onDelete(perform: deleteAssignments)
            }
            
        }
        .navigationTitle(subject.subjectName)
        .sheet(isPresented: $subjectViewModel.isAddingAssignment) {
            AddAssignmentView(isPresented: $subjectViewModel.isAddingAssignment, onAdd: { newAssignment in
                subjectViewModel.addAssignment(subject, newAssignment, modelContext: modelContext)
            })
        }
    }
    private func deleteAssignments(at offsets: IndexSet) {
        subjectViewModel.deleteAssignments(subject, at: offsets, modelContext: modelContext)
    }
}


