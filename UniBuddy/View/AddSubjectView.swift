//
//  AddSubjectView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 12/9/2024.
//

import SwiftUI

struct AddSubjectView: View {
    @StateObject private var addSubjectViewModel = AddSubjectViewModel()
    @Binding var isPresented: Bool
    var onAdd: (SubjectModel) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Subject Name", text: $addSubjectViewModel.subjectName)
                    TextField("Credit Points", text: $addSubjectViewModel.creditPoints)
                        .keyboardType(.numberPad)
                }
                
                Button("Add Subject") {
                    if let newSubject = addSubjectViewModel.createSubject() {
                        onAdd(newSubject)
                        isPresented = false
                    }
                }
                .disabled(!addSubjectViewModel.isValid)
            }
                
            .navigationTitle("Add New Subject")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
}


