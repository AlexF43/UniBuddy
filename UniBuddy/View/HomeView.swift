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
                    Spacer()
                    VStack(alignment: .center) {
                        Text("Looks like you dont have any subjects yet")
                            .font(.headline)
                        Text("If your marking this assignment I reccomend seeding the application with data using the button below, otherwise add your own subject using the add subject button")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    Button(action: {
                        seedExampleData()
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
    
    private func seedExampleData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let adnet = SubjectModel(subjectName: ".Net Development", creditPoints: 6, assignments: [
            AssignmentModel(taskName: "Quiz 1", weighting: 5, dueDate: dateFormatter.date(from: "2024-08-14") ?? Date(), completed: true, grade: 80),
            AssignmentModel(taskName: "Quiz 2", weighting: 5, dueDate: dateFormatter.date(from: "2024-08-28") ?? Date(), completed: true, grade: 70),
            AssignmentModel(taskName: "Quiz 3", weighting: 5, dueDate: dateFormatter.date(from: "2024-09-11") ?? Date(), completed: true),
            AssignmentModel(taskName: "VS console application", weighting: 35, dueDate: dateFormatter.date(from: "2024-09-23") ?? Date(), completed: false),
            AssignmentModel(taskName: "Quiz 4", weighting: 5, dueDate: dateFormatter.date(from: "2024-10-09") ?? Date(), completed: false)
        ])

        let aiosd = SubjectModel(subjectName: "Advanced iOS", creditPoints: 6, assignments: [
            AssignmentModel(taskName: "Solution Pitch Evaluation", weighting: 10, dueDate: dateFormatter.date(from: "2024-08-23") ?? Date(), completed: true),
            AssignmentModel(taskName: "Project 1", weighting: 30, dueDate: dateFormatter.date(from: "2024-09-15") ?? Date(), completed: false),
            AssignmentModel(taskName: "Project 2", weighting: 30, dueDate: dateFormatter.date(from: "2024-10-11") ?? Date(), completed: false)
        ])

        let ppp = SubjectModel(subjectName: "Professional Practice", creditPoints: 3, assignments: [
            AssignmentModel(taskName: "Reflective Learning Journal Part A", weighting: 0, dueDate: dateFormatter.date(from: "2024-08-26") ?? Date(), completed: true, grade: 100),
            AssignmentModel(taskName: "Competitive Professional Engineering", weighting: 50, dueDate: dateFormatter.date(from: "2024-09-02") ?? Date(), completed: true, grade: 100),
            AssignmentModel(taskName: "Reflective Learning Journal Part B", weighting: 50, dueDate: dateFormatter.date(from: "2024-09-09") ?? Date(), completed: true)
        ])

        let pm = SubjectModel(subjectName: "Project Management", creditPoints: 6, assignments: [
            AssignmentModel(taskName: "Online Assignment 1", weighting: 8.75, dueDate: dateFormatter.date(from: "2024-08-30") ?? Date(), completed: true, grade: 100),
            AssignmentModel(taskName: "Online Assignment 2", weighting: 8.75, dueDate: dateFormatter.date(from: "2024-09-20") ?? Date(), completed: true),
            AssignmentModel(taskName: "Online Assignment 3", weighting: 8.75, dueDate: dateFormatter.date(from: "2024-10-11") ?? Date(), completed: false)
        ])

        let epa = SubjectModel(subjectName: "EPA", creditPoints: 6, assignments: [
            AssignmentModel(taskName: "Project Evauation", weighting: 30, dueDate: dateFormatter.date(from: "2024-09-15") ?? Date(), completed: false)
        ])
        
        modelContext.insert(adnet)
        modelContext.insert(aiosd)
        modelContext.insert(ppp)
        modelContext.insert(pm)
        modelContext.insert(epa)

    }
}


