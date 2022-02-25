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
    
    var notebooks: Notebook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotebookController.shared.saveToPersistenceStore()
    }
    
    @IBAction func addEntry(_ sender: UIBarButtonItem) {
        guard let entryTitle = newEntryLabel.text,
              let body = bodyLabel.text,
              !entryTitle.isEmpty,
        let notebook = notebooks else { return }
        EntryController.createEntryWith(title: entryTitle, body: body, notebook: notebook)
        tableView.reloadData()
        newEntryLabel.text = ""
        bodyLabel.text = ""
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebooks?.journals.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard let notebook = notebooks else { return cell }
        
        let journal = notebook.journals[indexPath.row]
        
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = journal.body

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            guard let notebook = notebooks else { return }
            let entryToDelete = notebook.journals[indexPath.row]
            EntryController.deleteEntry(entry: entryToDelete, notebook: notebook)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        }    
    }


