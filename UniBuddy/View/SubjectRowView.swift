//
//  SubjectRowView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 12/9/2024.
//

import SwiftUI

/// row view for an individual subject
struct SubjectRowView: View {
    @Bindable var subject: SubjectModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(subject.subjectName)
                    .font(.headline)
                Text("\(subject.creditPoints) credit points")
                    .font(.body)
                    .foregroundColor(.secondary)
                Text(subject.daysUntilNextAssignmentString())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
        }
    }
}

