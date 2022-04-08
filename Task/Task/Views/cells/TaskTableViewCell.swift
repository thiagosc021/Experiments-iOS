//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Thiago Costa on 4/7/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isCompletedButton: UIButton!
    
    weak var taskCompleteDelegate: TaskCompleteDelegate?
    
    var task: Task? {
        didSet {
            updateView()
        }
    }
    
    fileprivate func configureButton(_ task: Task) {
        let notCompletedImage = UIImage(systemName: "square")
        let completedImage = UIImage(systemName: "checkmark.square")
        isCompletedButton.setTitle("", for: .normal)
        
        isCompletedButton.setImage( task.isComplete ? completedImage : notCompletedImage, for: .normal)
    }
    
    func updateView() {
        guard let task = task else {
            return
        }

        titleLabel.text = task.name
        configureButton(task)
        
    }
    
    @IBAction func didTapCompletionButton(_ sender: Any) {       
        taskCompleteDelegate?.taskCellButtonTapped(self)
    }
}
