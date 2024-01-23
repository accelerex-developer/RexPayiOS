//
//  OTPView.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

final class OTPContentVew: ScrollableView<ScrollViewContentSize>  {
    
    
    let priceLabel: Label = {
        let label = Label(text: "NGN 120,000", font: .poppinsBold(size: 23), textColor: .hex1A1A1A)
        return label
    }()
    
    let nameLabel: Label = {
        let label = Label(text: "Goyette and Sons", font: .poppinsRegular(size: 14), textColor: .hex9C9898)
        return label
    }()
    
    let headerLabel: Label = {
        let label = Label(text: "We sent an OTP to your device. Please, enter the OTP below to confirm transaction.", font: .poppinsRegular(size: 14), textColor: .hex1A1A1AWith72Alpha)
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexEDEDED
        view.layer.borderColor = UIColor.hexEDEDED.cgColor
        return view
    }()
    
    
    let placeholderTextField = BJTextField(title: "Placeholder Text")
    
    
    let paymentFooterView: PaymentFooterView = {
        let view = PaymentFooterView()
        return view
    }()
    
    let didngetCodeLabel: Label = {
        let label = Label(text: "Didn't get code?", font: .poppinsRegular(size: 14), textColor: .hex1A1A1AWith72Alpha)
        return label
    }()
    
    let resendCodeLabel: Label = {
        let label = Label(text: "Reesend code", font: .poppinsRegular(size: 14), textColor: .hexED1C25)
        return label
    }()
    
    let paymentBtn: Button = {
        let btn = Button(btnTitle: "Button Text", btnTextColor: .white, btnBackgroundColor: .hexED1C25, textFont: .poppinsMedium(size: 16))
        btn.cornerRadius = 6
        return btn
    }()
    
    override func setup() {
        super.setup()
        
        container.addSubviews(priceLabel, nameLabel, dividerView, headerLabel, placeholderTextField, didngetCodeLabel, resendCodeLabel, paymentBtn)
        priceLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20))

        nameLabel.anchor(top: priceLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 15, left: 20, bottom: 0, right: 20))

        dividerView.anchor(top: nameLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 0.7))

        headerLabel.anchor(top: dividerView.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))
        

        placeholderTextField.anchor(top: headerLabel.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        didngetCodeLabel.anchor(top: placeholderTextField.bottomAnchor, leading: container.leadingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        resendCodeLabel.anchor(top: placeholderTextField.bottomAnchor, leading: didngetCodeLabel.trailingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        paymentBtn.anchor(top: didngetCodeLabel.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        

        
        addSubview(paymentFooterView)
        paymentFooterView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .sides(20, 20), size: .init(height: 55))
    }
}
