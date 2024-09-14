//
//  AddSubjectViewModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 12/9/2024.
//

import Foundation

class AddSubjectViewModel: ObservableObject {

    @Published var subjectName: String = ""
    @Published var creditPoints: String = ""
    
    var isValid: Bool {
        !subjectName.isEmpty && !creditPoints.isEmpty && Int(creditPoints) != nil
    }
    
    func createSubject() -> SubjectModel? {
        guard let credits = Int(creditPoints), !subjectName.isEmpty else {
            return nil
        }
        return SubjectModel(subjectName: subjectName, creditPoints: credits, assignments: [])
    }
    
}
