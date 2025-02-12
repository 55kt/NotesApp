//
//  Home.swift
//  Notes
//
//  Created by Vlad on 11/2/25.
//

import SwiftUI

struct Home: View {
    // MARK: - Properties
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List(0..<9) { i in
                Text("We are at \(i)")
                    .padding()
            }// List
            .onAppear(perform: {
                fetchNotes()
            })
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarButtons.addNote(action: {})
                }// addNote
            }// toolbar
        }// NavigationStack
    }// Body
    
    // MARK: - Functions
    func fetchNotes() {
        let url = URL(string: "http://localhost:3000/notes")!
        
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let data = data else { return }
            
            print(String(data: data, encoding: .utf8) as Any)
        }
        
        task.resume()
    }
}// View

// MARK: - Preview
#Preview {
    Home()
}
