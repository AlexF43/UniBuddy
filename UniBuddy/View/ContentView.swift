//
//  ContentView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 11/9/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    //query to get subejcts from percistant storage
    @Query private var subjects: [SubjectModel]

    //the selected tab from the bottom bar
    @State private var tabSelection = 1
    
    var body: some View {
        
        // tab view along the bottom of all view, allowing the user to switch between grades, home and assignments
        TabView(selection: $tabSelection) {
            GradeView()
                .tabItem{
                    Label("Grades", systemImage: "chart.bar")
                }
                .tag(0)
            
            HomeView(subjects: subjects)
                .tabItem{
                    Label("Home", systemImage: "house")
                    
                }
                .tag(1)
            
            AssignmentsView()
                .tabItem {
                    Label("Assignments", systemImage: "list.bullet")
                }
                .tag(2)
            
        }.tint(.blue)
    }


}

