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
    @Query private var subjects: [SubjectModel]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(subjects) { subject in
                        NavigationLink(destination: SubjectDetailView(subject: subject)) {
                            VStack(alignment: .leading) {
                                Text(subject.subjectName)
                                    .font(.headline)
                                Text("Credit Points: \(subject.creditPoints)")
                                    .font(.subheadline)
                            }
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
        for index in offsets {
            modelContext.delete(subjects[index])
        }
    }
}


