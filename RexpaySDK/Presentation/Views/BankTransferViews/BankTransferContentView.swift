//
//  BankTransferContentView.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import UIKit

final class BankTransferContentView: ScrollableView<ScrollViewContentSize>  {
    
    
    let headerLabel: Label = {
        let label = Label(text: "Kindly click the button to get account details", font: .poppinsBold(size: 23), textColor: .hex1A1A1A, alignment: .center)
        return label
    }()
    
    let getAccountDetailsBtn: Button = {
        let btn = Button(btnTitle: "Get Account Details", btnTextColor: .white, btnBackgroundColor: .hexED1C25, textFont: .poppinsMedium(size: 16))
        btn.cornerRadius = 6
        return btn
    }()
    
    let bankNameLabel: Label = {
        let label = Label(text: "Bank name", font: .poppinsBold(size: 17), textColor: .hex1A1A1A, alignment: .center)
        return label
    }()
    
    let accountNameLabel: Label = {
        let label = Label(text: "Account name", font: .poppinsBold(size: 17), textColor: .hex1A1A1A, alignment: .center)
        return label
    }()
    
    let accountNumberLabel: Label = {
        let label = Label(text: "Account number", font: .poppinsBold(size: 17), textColor: .hex1A1A1A, alignment: .center)
        return label
    }()
    
    let paidBtn: Button = {
        let btn = Button(btnTitle: "I have completed the transaction", btnTextColor: .white, btnBackgroundColor: .hexED1C25, textFont: .poppinsMedium(size: 16))
        btn.cornerRadius = 6
        return btn
    }()
    
    let accountHeaderLabel: Label = {
        let label = Label(text: "Kindly proceed to your banking app mobile/internet to complete your bank transfer Please note the account number expires in 30 minutes", font: .poppinsRegular(size: 15), textColor: .hex1A1A1A, alignment: .center)
        return label
    }()
    
    let paymentFooterView: PaymentFooterView = {
        let view = PaymentFooterView()
        view.backgroundColor = .green
        return view
    }()
    
    override func setup() {
        super.setup()
        
        container.addSubviews(headerLabel, getAccountDetailsBtn, paymentFooterView)
        headerLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(height: 80))

        getAccountDetailsBtn.anchor(top: headerLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(height: 50))
        
        paymentFooterView.anchor(top: getAccountDetailsBtn.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(height: 200))
    }
    
    func showAccountDetailsView() {
        container.translatesAutoresizingMaskIntoConstraints = true
        container.subviews.forEach { $0.removeFromSuperview() }
        
        container.addSubviews(accountHeaderLabel, bankNameLabel, accountNameLabel, accountNumberLabel, paidBtn, paymentFooterView)
        
        accountHeaderLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20))
        
        bankNameLabel.anchor(top: accountHeaderLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20))

        accountNameLabel.anchor(top: bankNameLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 15, left: 20, bottom: 0, right: 20))
        
        accountNumberLabel.anchor(top: accountNameLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 15, left: 20, bottom: 0, right: 20))
        
        paidBtn.anchor(top: accountNumberLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 15, left: 20, bottom: 0, right: 20), size: .init(height: 50))
        
        paymentFooterView.anchor(top: paidBtn.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        layoutSubviews()
        layoutIfNeeded()
    }
}
