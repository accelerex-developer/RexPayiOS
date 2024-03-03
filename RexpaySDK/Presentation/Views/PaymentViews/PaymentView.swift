//
//  PaymentView.swift
//  RexpaySDK
//
//  Created by Abdullah on 22/01/2024.
//

import Foundation
import UIKit

class PaymentView: BaseView  {
    
    let myButtonn: Button = {
        let btn = Button(btnTitle: "Go to next", btnTextColor: .black, btnBackgroundColor: .hexFFB400, textFont: .poppinsExtraBold(size: 16))
        btn.cornerRadius = 12
        return btn
    }()
    
    let bagroundImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "img-bg", in: BundleHelper.resolvedBundle, with: nil))
        img.layer.borderColor = UIColor.hexD2543.cgColor
        img.layer.borderWidth = 1
        //img.backgroundColor = .hex707070
        return img
    }()
    
    let paymentContentView: PaymentContentView = {
        let view = PaymentContentView(scrollViewContentSize: .init(size: CGSize(width: Constant.screenWidth - 30, height: Constant.screenHeight * 0.7)))
        view.backgroundColor = .white
        view.cornerRadius = 4
        view.addShadow(offset: .init(width: 1, height: 1))
        return view
    }()
    
    let envLabel: Label = {
        let label = Label(text: "", font: .poppinsBold(size: 17), textColor: .black, alignment: .center, padding: .init(allEdges: 7))
        label.backgroundColor = .red
        return label
    }()
    
    override func setup() {
        super.setup()
        print("Constant.screenHeight is \(Constant.screenHeight)")
        addSubviews(bagroundImageView, paymentContentView, envLabel)
        bagroundImageView.fillUpSuperview()
        paymentContentView.placeAtCenterIn(centerY: centerYAnchor, centerX: centerXAnchor, size: .init(width: Constant.screenWidth - 30, height: Constant.screenHeight * 0.7))
        envLabel.anchor(leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor)
        
    }
}
