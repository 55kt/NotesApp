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
        } label: {
            HStack {
                Text("Add")
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundStyle(.primary)
            }
        }
    }
    
    // Update note button
    static func updateNote(isEditMode: Bool, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: isEditMode ? "checkmark" : "square.and.pencil")
                    .imageScale(.large)
                    .foregroundStyle(.primary)
                
                Text(isEditMode ? "Done" : "Edit")
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
            }
        }
    }
    
    
}// ToolbarButtons
