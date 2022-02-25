//
//  Notebook.swift
//  Journal
//
//  Created by Gino Tasis on 2/24/22.
//

import Foundation

class Notebook: Codable {
    
    var name: String
    var journals: [Entry]
    
    init(name: String, journals: [Entry] = []) {
        self.name = name
        self.journals = journals
    }
}

extension Notebook: Equatable {
    static func == (lhs: Notebook, rhs: Notebook) -> Bool {
        return lhs.name == rhs.name && lhs.journals == rhs.journals
}
}
