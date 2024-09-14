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
        NavigationView {
            Form {
                TextField("Task Name", text: $viewModel.taskName)
                TextField("Weighting (%)", text: $viewModel.weighting)
                    .keyboardType(.decimalPad)
                DatePicker("Due Date", selection: $viewModel.dueDate, displayedComponents: [.date])
                
                Button("Add Assignment") {
                    if let newAssignment = viewModel.createAssignment() {
                        onAdd(newAssignment)
                        isPresented = false
                    }
                }
                .disabled(!viewModel.isValid)
            }
            .navigationTitle("Add Assignment")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
}

