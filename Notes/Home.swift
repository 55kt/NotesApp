//
//  Home.swift
//  Notes
//
//  Created by Vlad on 11/2/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack {
            List(0..<9) { i in
                Text("We are at \(i)")
                    .padding()
            }// List
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarButtons.addNote(action: {})
                }// addNote
            }// toolbar
        }// NavigationStack
    }// Body
}// View

#Preview {
    Home()
}
