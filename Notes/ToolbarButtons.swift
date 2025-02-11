//
//  ToolbarButtons.swift
//  Notes
//
//  Created by Vlad on 11/2/25.
//

import SwiftUI

struct ToolbarButtons {
    // MARK: - Static buttons functions
    
    // Add note button
    static func addNote(action: @escaping () -> Void) -> some View {
        Button {
            action()
            print("Add a note")
        } label: {
            Image(systemName: "plus")
                .imageScale(.large)
                .foregroundStyle(.primary)
        }
    }
    
    
}// ToolbarButtons
