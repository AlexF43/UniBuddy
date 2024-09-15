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
    
    // sorts the subjects by closest due date
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
                // lists the subejects if there are any
                if (!sortedSubjects.isEmpty) {
                    List {
                        ForEach(sortedSubjects) { subject in
                            NavigationLink(destination: SubjectDetailView(subject: subject)) {
                                SubjectRowView(subject: subject)
                            }
                        }
                        .onDelete(perform: deleteSubjects)
                    }
                } else {
                    // if there are no subjects prompt the user to prefil them
                    Spacer()
                    VStack(alignment: .center) {
                        Text("Looks like you dont have any subjects yet")
                            .font(.headline)
                        Text("If your marking this assignment I reccomend seeding the application with data using the button below, otherwise add your own subject using the add subject button. If you would like to add the prefil data at another time, just remove all your subjects by swiping left across them")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    // button to prefill example data
                    Button(action: {
                        homeViewModel.seedExampleData(modelContext: modelContext)
                    }) {
                        Text("Prefill Example Data")
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
                
                Spacer()
                Spacer()
                
                // add subject button, when clicked bring up sheet to add a subject on
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
    
    // delete a subject from the list default delete behaviour by swiping
    func deleteSubjects(offsets: IndexSet) {
        let subjectsToDelete = offsets.map { sortedSubjects[$0] }
        for subject in subjectsToDelete {
            modelContext.delete(subject)
        }
    }

}


