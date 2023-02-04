//
//  ViewController.swift
//  SplashGUI
//
//  Created by Seyyedfarid Kamizi on 1/17/23.
//

import UIKit
import Foundation
import Splash

class SplashViewController: UIViewController {

    @IBOutlet var userCodeInput: UITextView!
    
    @IBOutlet var sysSpitter: UITextView!
    
    static let highligher = SyntaxHighlighter(format: HTMLOutputFormat())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func transform(_ sender: UIButton) {
        guard let input = userCodeInput.text else { return }
        
        let output = SplashViewController.highligher.highlight(input)
        sysSpitter.text = output
    }
    
}

