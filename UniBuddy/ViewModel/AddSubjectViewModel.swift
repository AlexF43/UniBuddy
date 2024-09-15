//
//  AddSubjectViewModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 12/9/2024.
//

import Foundation

class AddSubjectViewModel: ObservableObject {

    //fields for the add subejct form
    @Published var subjectName: String = ""
    @Published var creditPoints: String = ""
    
    /// checks if the entered values are correct
    var isValid: Bool {
        !subjectName.isEmpty && !creditPoints.isEmpty && Int(creditPoints) != nil && Int(creditPoints) ?? 0 >= 0
    }
    
    ///creates a subject from the entered data
    func createSubject() -> SubjectModel? {
        guard let credits = Int(creditPoints), !subjectName.isEmpty else {
            return nil
        }
        return SubjectModel(subjectName: subjectName, creditPoints: credits, assignments: [])
    }
    
}
