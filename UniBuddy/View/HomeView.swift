//
//  HomeView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 11/9/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @Environment(\.modelContext) private var modelContext
    var subjects: [SubjectModel]
    
    var sortedSubjects: [SubjectModel] {
        subjects.sorted {
            let days1 = $0.daysUntilNextAssignment() ?? Int.max
            let days2 = $1.daysUntilNextAssignment() ?? Int.max
            return days1 < days2
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(sortedSubjects) { subject in
                        NavigationLink(destination: SubjectDetailView(subject: subject)) {
                            SubjectRowView(subject: subject)
                        }
                    }
                    .onDelete(perform: deleteSubjects)
                }
                
                Button(action: {
                    homeViewModel.isAddingSubject = true
                }) {
                    Text("Add New Subject")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
            .navigationTitle("Subjects")
        }
        .sheet(isPresented: $homeViewModel.isAddingSubject) {
            AddSubjectView(isPresented: $homeViewModel.isAddingSubject, onAdd: { newSubject in
                homeViewModel.addSubject(newSubject, modelContext: modelContext)
            })
        }
    }
    
    private func deleteSubjects(offsets: IndexSet) {
        let subjectsToDelete = offsets.map { sortedSubjects[$0] }
        for subject in subjectsToDelete {
            modelContext.delete(subject)
        }
    }
}


