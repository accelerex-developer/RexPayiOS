//
//  RexpayPaymentController.swift
//  RexpaySDK
//
//  Created by Abdullah on 21/01/2024.
//

import Foundation
import UIKit

enum PaymentChannel: String {
    case payWithCard = "Pay with Card"
    case payWithUssd = "Pay with USSD"
    case payWithBank = "Pay with Bank"
}

struct PaymentChannelData {
    let leftIcon: String
    let title: PaymentChannel
    let rightIcon: String
}

final class PaymentController: UIViewController {
    
    let paymentView = PaymentView()
    
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
    
    override func loadView() {
        super.loadView()
        view = paymentView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        paymentView.myButtonn.onClick(completion: weakify({ strongSelf in
            print("I'm working .....")
        }))
        
        paymentView.paymentContentView.didSelectAt = weakify({ strongSelf, channelData in
            switch channelData.title {
            case .payWithCard:
                strongSelf.coordinator?.showCardPayment()
            case .payWithUssd:
                strongSelf.coordinator?.showUssdPayment()
            case .payWithBank:
                strongSelf.coordinator?.showBankPayment()
            }
        })
        
        
        
        configEnv()
        updateViewWithData()
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        config.delegate.didRecieveMessage(message: "PaymentController did apppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        config.delegate.didRecieveMessage(message: "PaymentController did disappear")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc func goToNext() {
        coordinator?.showCardPayment()
    }
    
    deinit {
        print("PaymentController is out from memory")
    }
    
    func updateViewWithData() {
        paymentView.paymentContentView.nameLabel.text = config.customerName
        paymentView.paymentContentView.priceLabel.text = "NGN \(config.amount)"
        paymentView.paymentContentView.data = getData()
    }
    
    fileprivate func configEnv() {
        switch config.rexpayEnv {
        case .production:
            paymentView.envLabel.text = ""
        case .sandbox:
            paymentView.envLabel.text = "Sandbox"
        }
    }
    
    func getData() -> [PaymentChannelData]{
        var data: [PaymentChannelData] = []
        for channel in config.selectedChannels {
            switch channel {
            case .bankTransfer:
                data.append(PaymentChannelData(leftIcon: "bank-building", title: .payWithBank, rightIcon: "right-arrow"))
            case .card:
                data.append(PaymentChannelData(leftIcon: "credit-card-payment", title: .payWithCard, rightIcon: "right-arrow"))
            case .ussd:
                data.append(PaymentChannelData(leftIcon: "pay-with-ussd", title: .payWithUssd, rightIcon: "right-arrow"))
            }
        }
        return data
    }
}
