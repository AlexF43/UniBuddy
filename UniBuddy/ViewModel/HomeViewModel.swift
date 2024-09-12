//
//  HomeViewModel.swift
//  UniBuddy
//
//  Created by Alex Fogg on 13/9/2024.
//

import SwiftUI
import SwiftData

@MainActor
class HomeViewModel: ObservableObject {
    @Published var isAddingSubject = false
    
    func addSubject(_ subject: SubjectModel, modelContext: ModelContext) {
        modelContext.insert(subject)
    }
}

