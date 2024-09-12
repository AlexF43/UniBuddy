//
//  HomeView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 11/9/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var subjects: [SubjectModel]
    
    var body: some View {
        Text("hello git")
    }
}

#Preview {
    HomeView()
}
