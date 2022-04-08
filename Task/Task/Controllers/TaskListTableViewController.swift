//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Thiago Costa on 4/5/22.
//

import UIKit

protocol TaskCompleteDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskListTableViewController: UITableViewController {
    
    var model = TaskController.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = model.fetchTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.countTasks()
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }

        let tasks = model.fetchTasks()
        let task = tasks[indexPath.row]

        cell.task = task
        cell.taskCompleteDelegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [UIContextualAction(style: .destructive, title: "Delete", handler: {[weak self] _, _, _ in
            guard let self = self else {
                return
            }
            let tasks = self.model.fetchTasks()
            let task = tasks[indexPath.row]
            self.model.delete(task: task)
            self.tableView.reloadData()
        })])
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? TaskDetailViewController,
              let selectedIndex = tableView.indexPathForSelectedRow  else {
            return
        }
        
        if segue.identifier == "taskDetailSegue" {
            let tasks = model.fetchTasks()
            destinationVC.task = tasks[selectedIndex.row]
        } 
    }

}

extension TaskListTableViewController: TaskCompleteDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else {
            return
        }
        self.model.toggleIsComplete(task: task)
        self.tableView.reloadData()
    }
}
