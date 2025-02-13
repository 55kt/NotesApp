//
//  Home.swift
//  Notes
//
//  Created by Vlad on 11/2/25.
//

import SwiftUI

struct Home: View {
    // MARK: - Properties
    @StateObject private var viewModel = NoteViewModel()
    @State var sheetIsPresented: Bool = false
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List(viewModel.notes) { note in
                Text(note.note)
                    .padding()
            }// List
            .sheet(isPresented: $sheetIsPresented, onDismiss: viewModel.fetchNotes, content: {
                AddNoteView()
            })
            .onAppear(perform: {
                viewModel.fetchNotes()
            })
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarButtons.addNote(action: {
                        self.sheetIsPresented.toggle()
                    })
                }// addNote
            }// toolbar
        }// NavigationStack
    }// Body
}// View

// MARK: - Preview
#Preview {
    Home()
}
