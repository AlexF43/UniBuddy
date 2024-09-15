//
//  AddAssignmentView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import SwiftUI

struct AddAssignmentView: View {
    @StateObject private var viewModel = AddAssignmentViewModel()
    @Binding var isPresented: Bool
    var onAdd: (AssignmentModel) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                // display the form for the user to enter details for a new assignment
                Form {
                    TextField("Task Name", text: $viewModel.taskName)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        TextField("Weighting (%)", text: $viewModel.weighting)
                            .keyboardType(.decimalPad)
                        
                        // communicate to the user that only numbers should be entered
                        if (viewModel.weighting != "" && Double(viewModel.weighting) == nil) {
                            Text("Please enter a valid number for weighting")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    DatePicker("Due Date", selection: $viewModel.dueDate, displayedComponents: [.date])
                }
                
                Spacer()
                
                // button to add assignment, only active if all entered fields are valid
                Button(action: {
                    if let newAssignment = viewModel.createAssignment() {
                        onAdd(newAssignment)
                        isPresented = false
                    }
                }) {
                    Text("Add Assignment")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(viewModel.isValid ? Color.blue : Color.gray)
                        )
                }
                .disabled(!viewModel.isValid)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Add Assignment")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
}
