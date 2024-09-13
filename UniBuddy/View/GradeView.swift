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
    @Query private var subjects: [SubjectModel]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(subjects) { subject in
                        SubjectCellView(subject: subject)
                    }
                }
                .padding()
            }
            .navigationTitle("Your Grades")
        }
    }
}
