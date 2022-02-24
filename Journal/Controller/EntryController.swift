//
//  EntryController.swift
//  Journal
//
//  Created by Gino Tasis on 2/23/22.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    func createEntryWith(title: String, body: String) {
        let newEntry = Entry(title: title, body: body)
        entries.append(newEntry)
    }
    
    func deleteEntry(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
    }
    
    //Persistence Store
    func persistentStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Journal.json")
        return fileURL
    }
    
    // save data
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: persistentStore())
        }
        catch let saveError {
            print(saveError)
        }
    }
    
    // load data
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: persistentStore())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        } catch {
            print(error)
        }
    }
    
}
