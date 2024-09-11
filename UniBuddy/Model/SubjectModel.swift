//
//  SubjectModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 11/9/2024.
//

import Foundation
import SwiftData

@Model
final class SubjectModel {
    var subjectName: String
    var creditPoints: Int
    var assignments: [AssignmentModel]
    
    init(subjectName: String, creditPoints: Int, assignments: [AssignmentModel]) {
        self.subjectName = subjectName
        self.creditPoints = creditPoints
        self.assignments = assignments
    }
}
