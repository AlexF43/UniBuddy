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

    @State private var tabSelection = 1
    
    var body: some View {
        // tabview with selection based on the value of "tabSelection"
        TabView(selection: $tabSelection) {
            GradeView()
                .tabItem{
                    Label("Grades", systemImage: "plus.circle")
                }
                .tag(0)
            
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "house")
                    
                }
                .tag(1)
            
            EmptyView()
                .tabItem {
                    Label("Assignments", systemImage: "book")
                }
                .tag(2)
            
        }.tint(.blue)
    }


}

