//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Thiago Costa on 3/29/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var modelController = EntryModelController(journalModelController: JournalModelController.shared)
    
    var journal: Journal?
    
    var entry: Entry? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        guard let entry = entry, self.isViewLoaded else {
            return
        }

        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        
        guard let title = titleTextField.text,
              let body = bodyTextView.text,
              let journal = journal else {
            //TODO: display an alert with the error message
            return
        }
        
        do {            
            if let entry = entry {
                try modelController.updateEntry(entry: entry, journal: journal)
            } else {
                try modelController.createEntry(with: title, body: body, journal: journal)
            }
            
        } catch let error {
            //TODO: display an alert with the error message
            print(error)
        }
        
        self.navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func clearForm() {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
}
