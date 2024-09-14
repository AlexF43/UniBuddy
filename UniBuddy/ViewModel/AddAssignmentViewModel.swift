//
//  AddAssignmentViewModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import Foundation

class AddAssignmentViewModel: ObservableObject {

    @Published var taskName = ""
    @Published var taskDescription = ""
    @Published var weighting = ""
    @Published var dueDate = Date()
    
    var isValid: Bool {
        !taskName.isEmpty && !weighting.isEmpty && Float(weighting) != nil
    }
    
    func createAssignment() -> AssignmentModel? {
        guard let weight = Float(weighting), !taskName.isEmpty else {
            return nil
        }
        return AssignmentModel(taskName: taskName, weighting: weight, dueDate: dueDate, completed: false)
    }
    
}
