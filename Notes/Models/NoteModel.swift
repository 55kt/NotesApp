//
//  NoteModel.swift
//  Notes
//
//  Created by Vlad on 12/2/25.
//

import Foundation

struct Note: Identifiable, Codable {
    var id: String { _id }
    var _id: String
    var note: String
}
