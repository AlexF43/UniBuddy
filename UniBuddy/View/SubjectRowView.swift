//
//  SubjectRowView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 12/9/2024.
//

import SwiftUI

struct SubjectRowView: View {
    var subject: SubjectModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(subject.subjectName)
                    .font(.headline)
                Text("\(subject.creditPoints) credit points")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(subject.daysUntilNextAssignmentString())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
        }
//        .padding()
        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(radius: 2)
    }
}

