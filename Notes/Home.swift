//
//  Home.swift
//  Notes
//
//  Created by Vlad on 11/2/25.
//

import SwiftUI

struct Home: View {
    // MARK: - Properties
    @State private var notes = [Note]()
    
    @State var sheetIsPresented: Bool = false
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List(self.notes) { note in
                Text(note.note)
                    .padding()
            }// List
            .sheet(isPresented: $sheetIsPresented, content: {
                AddNoteView()
            })
            .onAppear(perform: {
                fetchNotes()
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
    
    // MARK: - Functions
    func fetchNotes() {
        let url = URL(string: "http://localhost:3000/notes")!
        
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let data = data else { return }
            
            do {
                let notes = try JSONDecoder().decode([Note].self, from: data)
                self.notes = notes
            }
            catch {
                print(error)
            }// do - catch block
//            print(String(data: data, encoding: .utf8) as Any)
        }
        task.resume()
    }
}// View

// MARK: - Preview
#Preview {
    Home()
}
