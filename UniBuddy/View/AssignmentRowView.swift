//
//  AssignmnetRowView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 12/9/2024.
//

import SwiftUI

struct AssignmentRowView: View {
    @Bindable var assignment: AssignmentModel
    @Environment(\.modelContext) private var modelContext
    @State private var showingMarkAlert = false
    @State private var newGrade: String = ""
    
    var body: some View {
        HStack {
            Button(action: {
                assignment.completed.toggle()
                try? modelContext.save()
            }) {
                Image(systemName: assignment.completed ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.borderless)
            
            VStack(alignment: .leading) {
                Text(assignment.taskName)
                    .font(.headline)
                    .strikethrough(assignment.completed)
                Text(assignment.dateDifferenceString())
                    .font(.subheadline)
                Text("Weighting: \(assignment.weighting, specifier: "%.1f")%")
                    .font(.subheadline)
                if let grade = assignment.grade {
                    Text("Grade: \(grade, specifier: "%.1f")%")
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            if assignment.completed && assignment.grade == nil {
                Button(action: {
                    newGrade = "" 
                    showingMarkAlert = true
                }) {
                    Image(systemName: "pencil.circle")
                }
                .buttonStyle(.borderless)
            }
        }
        .alert("Mark Assignment", isPresented: $showingMarkAlert) {
            TextField("Grade", text: $newGrade)
                .keyboardType(.decimalPad)
            Button("Cancel", role: .cancel) { }
            Button("Add Grade") {
                if let grade = Float(newGrade) {
                    assignment.grade = grade
                    try? modelContext.save()
                }
            }
        } message: {
            Text("Enter the grade for this completed assignment:")
        }
    }
}

