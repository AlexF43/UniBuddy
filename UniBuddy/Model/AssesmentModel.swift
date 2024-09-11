//
//  Item.swift
//  UniBuddy
//
//  Created by Alex Fogg on 11/9/2024.
//

import Foundation
import SwiftData

@Model
final class AssignmentModel {
    var taskName: String
    var taskDescription: String?
    var weighting: Float
    var dueDate: Date
    
    init(taskName: String, taskDescription: String? = nil, weighting: Float, dueDate: Date) {
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.weighting = weighting
        self.dueDate = dueDate
    }
}
