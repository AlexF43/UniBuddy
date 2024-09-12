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
        VStack {
            Text(assignment.taskName)
                .font(.system(size: 16, weight: .bold))
            Text("Weighting: \(assignment.weighting)%")
            Text(assignment.dateDifferenceString())
        }
    }
    
    
}


