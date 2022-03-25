//
//  ModalViewController.swift
//  TestingClosures
//
//  Created by Thiago Costa on 3/24/22.
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var closure: ((Int) -> Void)?
    var currentScore = 0
    
    @IBAction func buttomTapped() {
        
        currentScore += 1
        closure?(currentScore)
        
    }
    
    

}
