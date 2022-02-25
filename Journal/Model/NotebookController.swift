//
//  NotebookController.swift
//  Journal
//
//  Created by Gino Tasis on 2/24/22.
//

import Foundation

class NotebookController {
    
    static let shared = NotebookController()
    
    var notebooks: [Notebook] = []
    
    func createNotebook(name: String) {
        let newNotebook = Notebook(name: name)
        notebooks.append(newNotebook)
        saveToPersistenceStore()
    }

    func deleteNotebook(notebook: Notebook) {
        let index = notebooks.firstIndex(of: notebook) ?? 0
        notebooks.remove(at: index)
        saveToPersistenceStore()
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
            let data = try JSONEncoder().encode(notebooks)
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
            notebooks = try JSONDecoder().decode([Notebook].self, from: data)
        } catch {
            print(error)
        }
    }
    
}
