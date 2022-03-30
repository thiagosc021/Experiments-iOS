//
//  ViewController.swift
//  AppEventCount
//
//  Created by Thiago Costa on 3/19/22.
//

import UIKit

class ViewController: UIViewController {
    
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    var sceneWillConnectToCount = 0
    var sceneDidBecomeActiveCount = 0
    var sceneWillResignActiveCount = 0
    var sceneWillEnterForegroundCount = 0
    var sceneDidEnterBackgroundCount = 0
    
    @IBOutlet private weak var didFinishLaunchingWithOptions: UILabel!
    @IBOutlet private weak var configurationForConnecting: UILabel!
    @IBOutlet private weak var sceneWillConnectTo: UILabel!
    @IBOutlet private weak var sceneDidBecomeActive: UILabel!
    @IBOutlet private weak var sceneWillResignActive: UILabel!
    @IBOutlet private weak var sceneWillEnterForeground: UILabel!
    @IBOutlet private weak var sceneDidEnterBackground: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        didFinishLaunchingWithOptions.text = "The App has launched \(appDelegate.launchCount) time(s)"
        configurationForConnecting.text = "ConfigurationForConnecting has been called \(appDelegate.configurationForConnectionCount) time(s)"
        sceneWillConnectTo.text = "sceneWillConnectTo has been called \(sceneWillConnectToCount) time(s)"
        sceneDidBecomeActive.text = "sceneDidBecomeActive has been called \(sceneDidBecomeActiveCount) time(s)"
        sceneWillResignActive.text = "sceneWillResignActive has been called \(sceneWillResignActiveCount) time(s)"
        sceneWillEnterForeground.text = "sceneWillEnterForeground has been called \(sceneWillEnterForegroundCount) time(s)"
        sceneDidEnterBackground.text = "sceneDidEnterBackground has been called \(sceneDidEnterBackgroundCount) time(s)"        
    }


}

