//
//  GradeCellView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 14/9/2024.
//
import SwiftUI

struct SubjectCellView: View {
    @Binding var subject: SubjectModel
    
    var body: some View {
        VStack {
            ZStack {
                // background circle
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                    .frame(width: 120, height: 120)
                
                // circle displaying completion % of the subject
                Circle()
                    .trim(from: 0, to: CGFloat(subject.calculateCompletion()))
                    .stroke(Color.blue.opacity(0.4), lineWidth: 12)
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                
                // circle showing the mark recieved for the subejct
                Circle()
                    .trim(from: 0, to: CGFloat(subject.calculateMarkOfCompleted()))
                     .stroke(Color.blue, lineWidth: 12)
                     .frame(width: 120, height: 120)
                     .rotationEffect(.degrees(-90))
                
                VStack {
                    Text("\(Int(subject.calculateMarkOfCompleted()*100))%")
                        .font(.title2)
                        .bold()
                    Text("\(Int(subject.calculateCompletion() * 100))% done")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            
            Text(subject.subjectName)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            // if a grade is able to be predicted (assignments have been marked and completed, display it in % form)
            if (subject.calculatePredictedGrade() != 0) {
                Text("Predicted grade: \(Int(subject.calculatePredictedGrade() * 100))%")
                    .font(.footnote)
            }

            Spacer()
        }
        .frame(width: 150, height: 180)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
}
