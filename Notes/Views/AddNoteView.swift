//
//  AddNoteView.swift
//  Notes
//
//  Created by Vlad on 12/2/25.
//

import SwiftUI

struct AddNoteView: View {
    // MARK: - Properties
    @ObservedObject var viewModel = NoteViewModel()
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    var body: some View {
        HStack {
            TextField("Write a note", text: $viewModel.text)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .clipped()
            
            Button {
                viewModel.postNote()
                dismiss()
            } label: {
                Text("Add")
                    .foregroundStyle(.primary)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }// Button
        }// HStack
    }// View
}// View

// MARK: - Preview
#Preview {
    AddNoteView()
}
