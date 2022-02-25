//
//  NotebookViewController.swift
//  Journal
//
//  Created by Gino Tasis on 2/24/22.
//

import UIKit

class NotebookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var insertNotebookName: UITextField!
    @IBOutlet weak var noteBookTitle: UILabel!
    @IBOutlet weak var notebookDetail: UILabel!
    @IBOutlet weak var notebookTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notebookTableView.delegate = self
        notebookTableView.dataSource = self
        notebookTableView.reloadData()
        NotebookController.shared.loadFromPersistenceStore()
        notebookTableView.backgroundColor = UIColor.clear

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notebookTableView.reloadData()
    }
    
    
    @IBAction func addNoteBookPressed(_ sender: UIButton) {

        guard let notebookName = insertNotebookName.text,
              !notebookName.isEmpty else { return }
        NotebookController.shared.createNotebook(name: notebookName)
        notebookTableView.reloadData()
        insertNotebookName.text = ""
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotebookController.shared.notebooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notebookTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.clear
        let notebook = NotebookController.shared.notebooks[indexPath.row]
        
        cell.textLabel?.text = notebook.name
        if (NotebookController.shared.notebooks.count == 1) {
            cell.detailTextLabel?.text = "\(notebook.journals.count) Entry"
        } else {
            cell.detailTextLabel?.text = "\(notebook.journals.count) Entries"
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "GoToJournal") {
            guard let indexPath = notebookTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? JournalTableViewController else { return }
            let notebook = NotebookController.shared.notebooks[indexPath.row]
            destinationVC.notebooks = notebook
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let notebookToDelete = NotebookController.shared.notebooks[indexPath.row]
            NotebookController.shared.deleteNotebook(notebook: notebookToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
}
