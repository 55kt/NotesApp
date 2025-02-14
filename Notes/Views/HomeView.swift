//
//  HomeView.swift
//  Notes
//
//  Created by Vlad on 11/2/25.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @StateObject private var viewModel = NoteViewModel()
    @State var sheetIsPresented: Bool = false
    @State var showAlert: Bool = false
    @State var isEditMode: EditMode = .inactive
    @State var updateNote = ""
    @State var updateNoteId = ""
    
    var alert: Alert {
        Alert(title: Text("Delete"), message: Text("Are you sure you want to delete this note?"), primaryButton: .destructive(Text("Delete"), action: viewModel.deleteNote), secondaryButton: .cancel())
    }
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List(viewModel.notes) { note in
                if(self.isEditMode == .inactive) {
                    Text(note.note)
                        .padding()
                        .onLongPressGesture {
                            self.showAlert.toggle()
                            viewModel.deleteItem = note
                        }
                }
                else {
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundStyle(.yellow)
                        
                        Text(note.note)
                            .padding()
                    }// HStack
                    .onTapGesture {
                        self.updateNote = note.note
                        self.updateNoteId = note.id
                        self.sheetIsPresented.toggle()
                    }
                }// if - else
            }// List
            .alert(isPresented: $showAlert, content: {
                alert
            })
            .sheet(isPresented: $sheetIsPresented, onDismiss: viewModel.fetchNotes, content: {
                if (self.isEditMode == .inactive) {
                    AddNoteView()
                }
                else {
                    UpdateNoteView(viewModel: viewModel, text: $updateNote, noteId: $updateNoteId)
                }// if - else
            })// sheet
            .onAppear(perform: {
                viewModel.fetchNotes()
            })
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ToolbarButtons.updateNote(isEditMode: isEditMode == .active) {
                        isEditMode = (isEditMode == .active) ? .inactive : .active
                    }
                }// updateNote
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
    HomeView()
}
