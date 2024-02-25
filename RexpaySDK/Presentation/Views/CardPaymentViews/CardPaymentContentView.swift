//
//  CardPaymentContentView.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

final class CardPaymentContentView: ScrollableView<ScrollViewContentSize>  {
    
    
    let priceLabel: Label = {
        let label = Label(text: "NGN 120,000", font: .poppinsBold(size: 23), textColor: .hex1A1A1A)
        return label
    }()
    
    let nameLabel: Label = {
        let label = Label(text: "Goyette and Sons", font: .poppinsRegular(size: 14), textColor: .hex9C9898)
        return label
    }()
    
    let headerLabel: Label = {
        let label = Label(text: "Please, enter your card details to make payment.", font: .poppinsRegular(size: 14), textColor: .hex1A1A1AWith72Alpha)
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexEDEDED
        view.layer.borderColor = UIColor.hexEDEDED.cgColor
        return view
    }()
    
    let cardNumberTextField: BJTextField = {
        let textField = BJTextField(title: "Card Number", keyboardType: .numberPad)
        textField.inputFormatter = "[0-9]{16,19}+"
        //^\d{16,19}$
        textField.errorMessage = "Please enter a valid card number"
        return textField
    }()
    
    let expiryDateTextField: BJTextField = {
        let textField = BJTextField(title: "Exp Date 03/25", keyboardType: .numberPad)
        //textField.inputFormatter = "[0-9]{4}+"
        //textField.inputFormatter = "^(0[1-9]|1[0-2])/(0[1-9]|[1-2][0-9]|3[01])$"
        textField.inputFormatter = "[0-9]{2}+/[0-9]{2}+"
        textField.shouldHandleCharacter = true;
        textField.errorMessage = "Please enter a valid expiry date"
        return textField
    }()
    
    let cvv2TextField: BJTextField = {
        let textField = BJTextField(title: "Cvv2", keyboardType: .numberPad)
        textField.inputFormatter = "[0-9]{3}+"
        textField.errorMessage = "Please enter a valid cvv2"
        textField.field.isSecureTextEntry = true
        return textField
    }()
    
    lazy var horizontalStack: HorizontalStack = {
        let stack = HorizontalStack(arrangedSubviews: [expiryDateTextField, cvv2TextField], spacing: 10, distribution: .fillEqually, alignment: .fill)
        //stack.layer.borderWidth = 1
        return stack
    }()
    
    let pinTextField: BJTextField = {
        let textField = BJTextField(title: "Pin", keyboardType: .numberPad)
        textField.inputFormatter = "[0-9]{4}+"
        textField.errorMessage = "Please enter a valid pin"
        textField.field.isSecureTextEntry = true
        return textField
    }()
    
    let paymentFooterView: PaymentFooterView = {
        let view = PaymentFooterView()
        return view
    }()
    
    let paymentBtn: Button = {
        let btn = Button(btnTitle: "Pay", btnTextColor: .white, btnBackgroundColor: .hexED1C25, textFont: .poppinsMedium(size: 16))
        btn.cornerRadius = 6
        return btn
    }()
    
    override func setup() {
        super.setup()
        
//        container.addSubviews(priceLabel, nameLabel, dividerView, headerLabel,cardNumberTextField, expiryDateTextField, cvv2TextField, pinTextField, paymentBtn, paymentFooterView)
        
        container.addSubviews(priceLabel, nameLabel, dividerView, headerLabel,cardNumberTextField, horizontalStack, pinTextField, paymentBtn, paymentFooterView)
        
        priceLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20))

        nameLabel.anchor(top: priceLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 15, left: 20, bottom: 0, right: 20))

        dividerView.anchor(top: nameLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 0.7))

        headerLabel.anchor(top: dividerView.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        cardNumberTextField.anchor(top: headerLabel.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
//        expiryDateTextField.anchor(top: cardNumberTextField.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(height: 55))
//
//        cvv2TextField.anchor(top: expiryDateTextField.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        horizontalStack.anchor(top: cardNumberTextField.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(height: 60))
        
        pinTextField.anchor(top: cvv2TextField.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 50, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        paymentBtn.anchor(top: pinTextField.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        paymentFooterView.anchor(top: paymentBtn.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
//        addSubview(paymentFooterView)
//        paymentFooterView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .sides(20, 20), size: .init(height: 55))
        scrollView.delegate = self
       
    }
    
    @objc func nextButtonTapped() {
           // Implement the logic for moving to the next text field
            print("na me")
       }
}

extension CardPaymentContentView: UIScrollViewDelegate {
    
}
