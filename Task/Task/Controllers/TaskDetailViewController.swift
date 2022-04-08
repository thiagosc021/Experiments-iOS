//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Thiago Costa on 4/5/22.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak private var taskNameTextfield: UITextField!
    @IBOutlet weak private var taskNotesTextView: UITextView!
    @IBOutlet weak private var taskDueDatePicker: UIDatePicker!
    
    var model = TaskController.shared
    
    var task: Task? {
        didSet {
            guard self.isViewLoaded else {
                return
            }
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = taskNameTextfield.text,
              let notes = taskNotesTextView.text else {
            return
        }
        
        let dueDate = taskDueDatePicker.date
        
        if let task = task {
            model.update(task: task, name: name, notes: notes, dueDate: dueDate)
        } else {
            model.createTaskWith(name: name, notes: notes, dueDate: dueDate)
        }
        
        dismissView()
    }
    
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        task?.dueDate = sender.date
    }
    
}

private extension TaskDetailViewController {
    func dismissView() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        guard let task = task else {
            return
        }
        
        taskNameTextfield.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
        taskNameTextfield.delegate = self
    }
}

extension TaskDetailViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
