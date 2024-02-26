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
    }
    
    @IBAction func clickMe(_ sender: UIButton) {
        let config = RexpaySDKConfig(
            reference: "sman024",
            amount: 210,
            userId: "awoyeyetimilehin@gmail.com",
            email: "awoyeyetimilehin@gmail.com",
            customerName: "Victor Musa",
            username: "talk2phasahsyyahoocom",
            password: "f0bedbea93df09264a4f09a6b38de6e9b924b6cb92bf4a0c07ce46f26f85",
            rexpayPublicKeyPath: "",
            publicKeyPath: "",
            privateKeyPath: "",
            delegate: self)
        
        config.passphrase = "pgptool77@@"

        let rexpaySDK = RexpaySDK(config: config)
        rexpaySDK.launch(presentingViewController: self)
    }
}

extension ViewController: RexpaySDKResponseDelegate {
    func didRecieveMessage(message: String) {
        print("callback mesages => \(message)")
    }
}

