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
        NavigationStack {
            VStack {
                // form to enter all new subejct infomation
                Form {
                    TextField("Subject Name", text: $addSubjectViewModel.subjectName)
                    VStack(alignment: .leading, spacing: 5) {
                        TextField("Credit Points", text: $addSubjectViewModel.creditPoints)
                            .keyboardType(.numberPad)
                        
                        if (addSubjectViewModel.creditPoints != "" && Int(addSubjectViewModel.creditPoints) == nil) {
                            // communicate to the user to only enter numbers into the field
                            Text("Please only enter numbers for credit points")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Spacer()
                
                // button for adding subejct that is only active when all entered items in the field are valid
                Button(action: {
                    if let newSubject = addSubjectViewModel.createSubject() {
                        onAdd(newSubject)
                        isPresented = false
                    }
                }) {
                    Text("Add Subject")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(addSubjectViewModel.isValid ? Color.blue : Color.gray)
                        )
                }
                .disabled(!addSubjectViewModel.isValid)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Add New Subject")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
}


