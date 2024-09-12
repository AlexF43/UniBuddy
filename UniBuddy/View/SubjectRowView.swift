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
        VStack {
            Text(subject.subjectName)
            Text("current grade \(subject.calculateSubjectGrade())%")
            Text(subject.daysUntilNextAssignmentString())
        }
        
    }
}

