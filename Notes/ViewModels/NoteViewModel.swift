//
//  NoteViewModel.swift
//  Notes
//
//  Created by Vlad on 13/2/25.
//

import SwiftUI

class NoteViewModel: ObservableObject {
    // MARK: - Properties
    @Published var text: String = ""
    @Published var notes: [Note] = []
    @Published var deleteItem: Note?

    // MARK: - Methods

    /// Fetching all notes from server
    func fetchNotes() {
        let url = URL(string: "http://localhost:3000/notes")!
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, res, err in
            guard let self = self else { return }
            guard let data = data else { return }
            
            do {
                let fetchedNotes = try JSONDecoder().decode([Note].self, from: data)
                DispatchQueue.main.async {
                    self.notes = fetchedNotes
                }
            }
            catch {
                print("Error JSON decoding: \(error)")
            }
        }
        task.resume()
    }// fetchNotes
    
    /// Delete a note
    func deleteNote() {
        guard let id = deleteItem?._id else { return }
        
        let url = URL(string: "http://localhost:3000/notes/\(id)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "Delete"
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Response from server: \(json)")
                }
            }
            catch let error {
                print("Error response deleting note: \(error)")
            }
        }
        task.resume()
        
        fetchNotes()
    }// deleteNote

    /// Sending a new note to the server
    func postNote() {
        let params = ["note": text] as [String: Any]
        let url = URL(string: "http://localhost:3000/notes")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        catch let error {
            print("Error Serializing JSON: \(error)")
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, res, err in
            guard let self = self else { return }
            guard err == nil else {
                print("Error request: \(err!.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Response from server: \(json)")
                    DispatchQueue.main.async {
                        self.fetchNotes() // Update the list of notes after adding a new one
                        self.text = ""
                    }
                }
            }
            catch let error {
                print("Error response parsing: \(error)")
            }
        }
        
        task.resume()
    }// postNote
}

