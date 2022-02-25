//
//  EntryController.swift
//  Journal
//
//  Created by Gino Tasis on 2/23/22.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    static func createEntryWith(title: String, body: String, notebook: Notebook) {
        let newEntry = Entry(title: title, body: body)
        notebook.journals.append(newEntry)
        NotebookController.shared.saveToPersistenceStore()
    }
    
   static func deleteEntry( entry: Entry, notebook: Notebook) {
        guard let index = notebook.journals.firstIndex(of: entry) else { return }
        notebook.journals.remove(at: index)
        NotebookController.shared.saveToPersistenceStore()
    }
    
    
}
