//
//  AddAssignmentViewModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import Foundation

class AddAssignmentViewModel: ObservableObject {

    //variables for the forms field
    @Published var taskName = ""
    @Published var taskDescription = ""
    @Published var weighting = ""
    @Published var dueDate = Date()
    
    ///checks the entered values are valid. used to enable/disable the add button
    var isValid: Bool {
        !taskName.isEmpty && !weighting.isEmpty && Float(weighting) ?? 0 > 0
    }
    
    ///creates a assignment model based off the values entered into the form
    func createAssignment() -> AssignmentModel? {
        guard let weight = Float(weighting), !taskName.isEmpty else {
            return nil
        }
        return AssignmentModel(taskName: taskName, weighting: weight, dueDate: dueDate, completed: false)
    }
    
}
