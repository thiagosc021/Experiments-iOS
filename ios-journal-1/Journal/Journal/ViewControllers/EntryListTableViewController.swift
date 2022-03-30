//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Thiago Costa on 3/29/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    var modelController = EntryModelController.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = modelController.listEntries()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.countEntries()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entries = modelController.listEntries()
        
        let entry = entries[indexPath.row]
        
        cell.textLabel?.text = entry.title

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EntryDetailViewController,
        let index = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        destination.entry =  modelController.listEntries()[index.row]
    }
}
