//
//  AddNoteView.swift
//  Notes
//
//  Created by Vlad on 12/2/25.
//

import SwiftUI

struct AddNoteView: View {
    // MARK: - Properties
    @State private var text = ""
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    var body: some View {
        HStack {
            TextField("Write a note", text: $text)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .clipped()
            
            Button {
                postNote()
            } label: {
                Text("Add")
                    .foregroundStyle(.primary)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }// Button
        }// HStack
    }// View
    
    // MARK: - Functions
    func postNote() {
        let params = ["note" : text] as [String : Any]
        
        let url = URL(string: "http://localhost:3000/notes")!
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        catch let error {
            print(error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            }
            catch let error {
                print(error)
            }
        }
        
        task.resume()
        
        self.text = ""
        dismiss()
    }// postNote func
}// View

// MARK: - Preview
#Preview {
    AddNoteView()
}
