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
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = GradeViewModel()
    
    // display grades in a 2 wide collum
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        // display the users wam and gpa
                        VStack(alignment: .leading) {
                            Text("Predicted WAM: \(viewModel.calculateWAM(), specifier: "%.2f")")
                            Text("Predicted GPA: \(viewModel.calculateGPA(), specifier: "%.2f")")
                        }
                        .font(.headline)
                        .padding()
                        Spacer()
                    }
                    // display the subject grades in a grid
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach($viewModel.subjects) { subject in
                            SubjectCellView(subject: subject)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Your Grades")
            }
        }
        // when the screen is shown get the subejct data
        .onAppear {
            viewModel.fetchSubjects(modelContext: modelContext)
        }
    }
}
