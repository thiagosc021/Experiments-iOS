//
//  JournalListViewController.swift
//  Journal
//
//  Created by Thiago Costa on 4/4/22.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalListTableView.dataSource = self
        journalListTableView.delegate = self
        JournalModelController.shared.loadJournalList()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func createNewJournalButtonTapped() {
        guard let title = journalTitleTextField.text else {
            return
        }
        do {
            try JournalModelController.shared.createJournalWith(title: title)
        } catch let error {
            print(error)
            return
        }
        self.journalListTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? EntryListTableViewController,
            let indexPathSelected = self.journalListTableView.indexPathForSelectedRow else {
            return
        }
        
        let journal = JournalModelController.shared.getJournal(by: indexPathSelected.row)
        
        destinationVC.journal = journal
    }
    
}

extension JournalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalModelController.shared.journalCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        let journal = JournalModelController.shared.getJournal(by: indexPath.row)
        
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(journal.entries.count) entries"
        
        return cell
    }
    
    
}
