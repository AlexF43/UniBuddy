//
//  GradeViewModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 15/9/2024.
//

import Foundation
import SwiftData

class GradeViewModel: ObservableObject {
    @Published var subjects: [SubjectModel] = []
    
    /// fetch the subjects, called on appear of the screen.
    /// annotated with main actor since it will cause UI upadates
    @MainActor
    func fetchSubjects(modelContext: ModelContext) {
        let fetchDescriptor = FetchDescriptor<SubjectModel>()
        subjects = (try? modelContext.fetch(fetchDescriptor)) ?? []
    }
    
    /// calculates the predicted WAM
    func calculateWAM() -> Float {
        var totalCreditPoints = 0
        var totalWeightedMark: Float = 0.0
        for subject in subjects {
            if (subject.calculateWeightOfMarked() != 0) {
                totalCreditPoints += subject.creditPoints
                totalWeightedMark += Float(subject.calculatePredictedGrade()) * Float(subject.creditPoints)
            }
        }
        
        return (totalWeightedMark / Float(totalCreditPoints)) * 100
    }
    
    /// calculates the predicted GPA
    func calculateGPA() -> Float {
        var totalCreditPoints = 0
        var totalWeightedGrade = 0
        
        for subject in subjects {
            if (subject.calculateWeightOfMarked() != 0) {
                totalCreditPoints += subject.creditPoints
                let grade = subject.calculatePredictedGrade() * 100
                switch(grade) {
                case 85...100:
                    totalWeightedGrade += 7 * subject.creditPoints
                case 75..<85:
                    totalWeightedGrade += 6 * subject.creditPoints
                case 65..<75:
                    totalWeightedGrade += 5 * subject.creditPoints
                case 50..<65:
                    totalWeightedGrade += 4 * subject.creditPoints
                case ..<50:
                    print("Fail")
                default:
                    print("No Grade")
                }
            }
        }
        
        return Float(totalWeightedGrade) / Float(totalCreditPoints)
    }
}
