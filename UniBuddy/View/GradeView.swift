//
//  GradeView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 11/9/2024.
//
import SwiftUI
import SwiftData

import Foundation

struct GradeView: View {
//    var subjects: [SubjectModel]
    @Environment(\.modelContext) private var modelContext
//    @Query private
    @State var subjects: [SubjectModel] = []
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Predicted WAM: \(calculateWAM(), specifier: "%.2f")")
                            Text("Predicted GPA: \(calculateGPA(), specifier: "%.2f")")
                        }
                        .font(.headline)
                        .padding()
                        Spacer()
                    }
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach($subjects) { subject in
                            SubjectCellView(subject: subject)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Your Grades")
            }
        }
        .onAppear() {
            let fetchDescriptor = FetchDescriptor<SubjectModel>()
            subjects = try! modelContext.fetch(fetchDescriptor)
        }
    }
    
    func calculateWAM() -> Float {
        var totalCreditPoints = 0
        var totalWeightedMark: Float = 0.0
        for subject in subjects {
            totalCreditPoints += subject.creditPoints
            totalWeightedMark += Float(subject.calculatePredictedGrade())*Float(subject.creditPoints)
        }
        
        return (totalWeightedMark/Float(totalCreditPoints)) * 100
    }
    
    func calculateGPA() -> Float {
        var totalCreditPoints = 0
        var totalWeightedGrade = 0
        
        for subject in subjects {
            totalCreditPoints += subject.creditPoints
            let grade = subject.calculatePredictedGrade() * 100
            switch(grade) {
            case 85...100:
                totalWeightedGrade += Int(7)*subject.creditPoints
            case 75..<85:
                totalWeightedGrade += Int(6)*subject.creditPoints
            case 65..<75:
                totalWeightedGrade += Int(5)*subject.creditPoints
            case 50..<65:
                totalWeightedGrade += Int(4)*subject.creditPoints
            case ..<50:
                print("failed")
                break
            default:
                print("no grade")
                break
            }
        }
        
        return Float(totalWeightedGrade)/Float(totalCreditPoints)
    }
}
