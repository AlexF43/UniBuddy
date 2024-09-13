//
//  AssignmnetRowView.swift
//  UniBuddy
//
//  Created by Alex Fogg on 12/9/2024.
//

import SwiftUI

struct AssignmnetRowView: View {
    var assignment: AssignmentModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(assignment.taskName)
                .font(.headline)
            Text(assignment.dateDifferenceString())
                .font(.subheadline)
            Text("Weighting: \(assignment.weighting, specifier: "%.1f")%")
                .font(.subheadline)
        }
    }
    
}


