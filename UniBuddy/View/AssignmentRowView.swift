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
                if (assignment.completed == true) {
                    assignment.grade = nil
                }
                assignment.completed.toggle()
                try? modelContext.save()
            }) {
                Image(systemName: assignment.completed ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.borderless)
            
            VStack(alignment: .leading) {
                Text(assignment.taskName)
                    .font(.headline)
                Text(assignment.dateDifferenceString())
                    .font(.subheadline)
                Text("Weighting: \(assignment.weighting, specifier: "%.1f")%")
                    .font(.subheadline)
            }
                
            
            Spacer()
            
            if (assignment.completed) {
                Button(action: {
                    newGrade = ""
                    showingMarkAlert = true
                }) {
                    
                    if let grade = assignment.grade {
                        Text("\(grade, specifier: "%.1f")%")
                            .font(.subheadline)
                    } else {
                        HStack(spacing: 5) {
                            Text("Mark")
                                .font(.system(size: 14, weight: .medium))
                            Image(systemName: "pencil")
                                .font(.system(size: 14))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.blue)
                        )
                    }
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
                    if (grade >= 0) {
                        assignment.grade = grade
                        try? modelContext.save()
                    }
                }
            }
        } message: {
            Text("Enter the percentage mark recieved for this assignment")
        }
    }
}

