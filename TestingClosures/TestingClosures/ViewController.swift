//
//  ViewController.swift
//  TestingClosures
//
//  Created by Thiago Costa on 3/24/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var scoreLabel: UILabel!
    var currentScore = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ModalViewController else {
            return
        }
        destinationVC.currentScore = currentScore
        destinationVC.closure = { [weak self] currentValue in
            guard let self = self else { return }
            self.currentScore = currentValue
            self.scoreLabel.text = "Score: \(currentValue)"
        }
        
    }
}

