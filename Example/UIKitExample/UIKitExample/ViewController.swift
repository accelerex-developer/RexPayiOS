//
//  ViewController.swift
//  UIKitExample
//
//  Created by Abdullah on 21/01/2024.
//

import UIKit
import RexpaySDK

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickMe(_ sender: UIButton) {
        let config = RexpaySDKConfig()
        config.amount = 20
        config.email = "email"
        config.delegate = self

        let rexpaySDK = RexpaySDK(config: config)
        rexpaySDK.launch(presentingViewController: self)
    }
}

extension ViewController: RexpaySDKResponseDelegate {
    func didRecieveMessage(message: String) {
        print("Rexpay => \(message)")
    }
}

