//
//  UssdContentView.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import UIKit

final class UssdContentView: ScrollableView<ScrollViewContentSize>  {
    
    
    let headerLabel: Label = {
        let label = Label(text: "Please choose a bank to continue with the payment", font: .poppinsBold(size: 18), textColor: .hex1A1A1A, alignment: .center)
        return label
    }()
    
    let bankContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    let selectedBankLabel: Label = {
        let label = Label(text: "Select Bank", font: .poppinsRegular(size: 15), textColor: .lightGray)
        return label
    }()
    
    let arrowImgView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "down-arrow-2", in: BundleHelper.resolvedBundle, with: nil))
        img.layer.borderColor = UIColor.hexD2543.cgColor
        img.contentMode = .center
        return img
    }()

    let ussdCodeContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let codeWillAppearLabel: Label = {
        let label = Label(text: "Your ussd code will appear here", font: .poppinsRegular(size: 15), textColor: .lightGray, alignment: .center)
        return label
    }()
    
    let dialCodeHeaderLabel: Label = {
        let label = Label(text: "Dial the below code to complete the payment", font: .poppinsRegular(size: 15), textColor: .lightGray, alignment: .center)
        return label
    }()
    
    let ussdCodeLabel: Label = {
        let label = Label(text: "*333*33*", font: .poppinsRegular(size: 15), textColor: .black, alignment: .center)
        return label
    }()
    
    let checkTransactionStatusLabel: Label = {
        let label = Label(text: "Check transaction status", font: .poppinsRegular(size: 15), textColor: .hexED1C25, alignment: .center, underlined: true)
        return label
    }()
    
    let paymentFooterView: PaymentFooterView = {
        let view = PaymentFooterView()
        return view
    }()
    
    var isArrowToggled = false
    
    override func setup() {
        super.setup()
        
        container.addSubviews(headerLabel, bankContainerView, ussdCodeContainerView, paymentFooterView)
        headerLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20))
        
        bankContainerView.anchor(top: headerLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(height: 55))
        
        bankContainerView.addSubviews(arrowImgView, selectedBankLabel)
        arrowImgView.anchor(top: bankContainerView.topAnchor, bottom: bankContainerView.bottomAnchor, trailing: bankContainerView.trailingAnchor, margin: .rightOnly(10))
        selectedBankLabel.anchor(top: bankContainerView.topAnchor, leading: bankContainerView.leadingAnchor, bottom: bankContainerView.bottomAnchor, trailing: arrowImgView.leadingAnchor, margin: .leftOnly(15))
        
        
        ussdCodeContainerView.anchor(top: bankContainerView.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(height: 135))
        
        ussdCodeContainerView.addSubview(codeWillAppearLabel)
        codeWillAppearLabel.fillUpSuperview()
        
        
        paymentFooterView.anchor(top: ussdCodeContainerView.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(height: 55))
    }
    
    func toggleArrow() {
        if isArrowToggled {
            arrowImgView.image = UIImage(named: "down-arrow-2", in: BundleHelper.resolvedBundle, with: nil)
            isArrowToggled = false
        }
        else {
            arrowImgView.image = UIImage(named: "up-arrow-2", in: BundleHelper.resolvedBundle, with: nil)
            isArrowToggled = true
        }
    }
    
    func showUssdCodeView() {
        ussdCodeContainerView.subviews.forEach { $0.removeFromSuperview() }
        
        ussdCodeContainerView.addSubviews(dialCodeHeaderLabel, ussdCodeLabel, checkTransactionStatusLabel)
        dialCodeHeaderLabel.anchor(top: ussdCodeContainerView.topAnchor, leading: ussdCodeContainerView.leadingAnchor, trailing: ussdCodeContainerView.trailingAnchor, margin: .topOnly(10))
        
        ussdCodeLabel.anchor(top: dialCodeHeaderLabel.bottomAnchor, leading: ussdCodeContainerView.leadingAnchor, trailing: ussdCodeContainerView.trailingAnchor, margin: .topOnly(15))
        
        checkTransactionStatusLabel.anchor(top: ussdCodeLabel.bottomAnchor, leading: ussdCodeContainerView.leadingAnchor, trailing: ussdCodeContainerView.trailingAnchor, margin: .topOnly(10))
    }
}
