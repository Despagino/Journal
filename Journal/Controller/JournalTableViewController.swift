//
//  JournalTableViewController.swift
//  Journal
//
//  Created by Gino Tasis on 2/23/22.
//

import UIKit

class JournalTableViewController: UITableViewController {

    
    @IBOutlet weak var newEntryLabel: UITextField!
    @IBOutlet weak var bodyLabel: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        EntryController.shared.loadFromPersistenceStore()
    }
    
    @IBAction func addEntry(_ sender: UIBarButtonItem) {
        guard let entryTitle = newEntryLabel.text,
              let body = bodyLabel.text,
              !entryTitle.isEmpty else { return }
        EntryController.shared.createEntryWith(title: entryTitle, body: body)
        tableView.reloadData()
        newEntryLabel.text = ""
        bodyLabel.text = ""
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.body

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            EntryController.shared.deleteEntry(entry: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        }    
    }


