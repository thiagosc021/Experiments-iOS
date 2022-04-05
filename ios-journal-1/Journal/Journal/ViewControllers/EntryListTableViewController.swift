//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Thiago Costa on 3/29/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    
    var modelController = EntryModelController(journalModelController: JournalModelController.shared)

    var journal: Journal? {
        didSet {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        guard let entries = journal?.entries else {
            return UITableViewCell()
        }
        
        let entry = entries[indexPath.row]
        
        cell.textLabel?.text = entry.title

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? EntryDetailViewController else {
            return
        }
        
        if segue.identifier == "addEntry" {
            destination.journal = journal
        } else {
            guard let index = self.tableView.indexPathForSelectedRow,
                  let entries = journal?.entries else {
                return
            }
            
            destination.entry =  entries[index.row]
            destination.journal = journal
        }
        
    }
}
