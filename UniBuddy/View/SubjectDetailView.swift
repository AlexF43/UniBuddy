//
//  SubjectDetailView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import SwiftUI

struct SubjectDetailView: View {
    var subject: SubjectModel
    
    var body: some View {
        Text("\(subject.subjectName)")
    }
}

