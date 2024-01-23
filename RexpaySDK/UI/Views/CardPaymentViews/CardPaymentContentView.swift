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
    
    let cardNumberTextField = BJTextField(title: "Card Number")
    
    let placeholderTextField = BJTextField(title: "Placeholder Text")
    
    let placeholderTextField2 = BJTextField(title: "Placeholder Text")
    
    let paymentFooterView: PaymentFooterView = {
        let view = PaymentFooterView()
        return view
    }()
    
    let paymentBtn: Button = {
        let btn = Button(btnTitle: "Button Text", btnTextColor: .white, btnBackgroundColor: .hexED1C25, textFont: .poppinsMedium(size: 16))
        btn.cornerRadius = 6
        return btn
    }()
    
    override func setup() {
        super.setup()
        
        container.addSubviews(priceLabel, nameLabel, dividerView, headerLabel,cardNumberTextField, placeholderTextField, placeholderTextField2, paymentBtn, paymentFooterView)
        priceLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20))

        nameLabel.anchor(top: priceLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 15, left: 20, bottom: 0, right: 20))

        dividerView.anchor(top: nameLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 0.7))

        headerLabel.anchor(top: dividerView.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        cardNumberTextField.anchor(top: headerLabel.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        placeholderTextField.anchor(top: cardNumberTextField.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        placeholderTextField2.anchor(top: placeholderTextField.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        paymentBtn.anchor(top: placeholderTextField2.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        paymentFooterView.anchor(top: paymentBtn.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
//        addSubview(paymentFooterView)
//        paymentFooterView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .sides(20, 20), size: .init(height: 55))
    }
}
