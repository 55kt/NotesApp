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
    @State var showAlert: Bool = false
    
    
    var alert: Alert {
        Alert(title: Text("Delete"), message: Text("Are you sure you want to delete this note?"), primaryButton: .destructive(Text("Delete"), action: viewModel.deleteNote), secondaryButton: .cancel())
    }
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List(viewModel.notes) { note in
                Text(note.note)
                    .padding()
                    .onLongPressGesture {
                        self.showAlert.toggle()
                        viewModel.deleteItem = note
                    }
            }// List
            .alert(isPresented: $showAlert, content: {
                alert
            })
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
