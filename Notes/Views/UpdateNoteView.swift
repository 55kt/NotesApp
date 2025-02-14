//
//  UpdateNoteView.swift
//  Notes
//
//  Created by Vlad on 13/2/25.
//

import SwiftUI

struct UpdateNoteView: View {
    // MARK: - Properties
    @ObservedObject var viewModel = NoteViewModel()
    @Environment(\.dismiss) var dismiss
    @Binding var text: String
    @Binding var noteId: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            TextField("Update a note", text: $text)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .clipped()
            
            Button {
                viewModel.updateNote(text: text, noteId: noteId)
                dismiss()
            } label: {
                Text("Update")
                    .foregroundStyle(.primary)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }// Button
        }// HStack
    }// Body
}// View

// MARK: - Preview
#Preview {
    UpdateNoteView(text: .constant(""), noteId: Binding.constant(""))
}
