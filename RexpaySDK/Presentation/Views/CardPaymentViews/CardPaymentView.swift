//
//  CardPaymentView.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

final class CardPaymentView: BaseView {
    
    let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.isHidden = true
        return view
    }()
    
    let cardPaymentContentView: CardPaymentContentView = {
        let view = CardPaymentContentView(scrollViewContentSize: .init(size: CGSize(width: Constant.screenWidth - 30, height: Constant.screenHeight * 0.7)))
        view.backgroundColor = .white
        view.cornerRadius = 4
        view.addShadow(offset: .init(width: 1, height: 1))
        return view
    }()
    
    let bagroundImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "img-bg", in: Bundle(for: CardPaymentView.self), with: nil))
        img.layer.borderColor = UIColor.hexD2543.cgColor
        img.layer.borderWidth = 1
        //img.backgroundColor = .hex707070
        return img
    }()
    
    let leftArrowImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "left-arrow", in: Bundle(for: CardPaymentView.self), with: nil))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
//    let leftArrowView: UIImageView = {
//        let view = UIView()
//        let img = UIImageView(image: UIImage(named: "left-icon", in: Bundle(for: CardPaymentView.self), with: nil))
//        img.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(img)
//        img.fillUpSuperview()
//        return img
//    }()
    
    override func setup() {
        super.setup()
        
        print("Constant.screenHeight is \(Constant.screenHeight)")
        addSubviews(bagroundImageView, leftArrowImg, cardPaymentContentView, topContainerView)
        bagroundImageView.fillUpSuperview()
        
        leftArrowImg.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, margin: .topLeftOnly(15, 15), size: .init(width: 25, height: 25))
        
        cardPaymentContentView.placeAtCenterIn(centerY: centerYAnchor, centerX: centerXAnchor, size: .init(width: Constant.screenWidth - 30, height: Constant.screenHeight * 0.7))
        
        topContainerView.anchor(leading: leadingAnchor, bottom: cardPaymentContentView.topAnchor, trailing: trailingAnchor,size: .init(height: 60))
    }
}
