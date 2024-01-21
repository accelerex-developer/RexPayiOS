//
//  RexpayPaymentController.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
import UIKit

final class PaymentController: UIViewController {
    
    let myButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Go to next", for: .normal)
        return btn
    }()
    
    private var config: RexpaySDKConfig
    
    var coordinator: MainCoordinator?
    
    public init(config: RexpaySDKConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(myButton)
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        myButton.addTarget(self, action: #selector(goToNext), for: .touchUpInside)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate?.didRecieveMessage(message: "PaymentController did apppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        config.delegate?.didRecieveMessage(message: "PaymentController did disappear")
    }
    
    @objc func goToNext() {
        coordinator?.showCardPayment()
    }
    
    deinit {
        print("PaymentController is out from memory")
    }
}
