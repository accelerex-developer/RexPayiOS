//
//  UssdView.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import UIKit

final class UssdView: BaseView {
    
    let ussdContentView: UssdContentView = {
        let view = UssdContentView(scrollViewContentSize: .init(size: CGSize(width: Constant.screenWidth - 30, height: Constant.screenHeight * 0.5)))
        view.backgroundColor = .white
        view.cornerRadius = 4
        view.addShadow(offset: .init(width: 1, height: 1))
        return view
    }()
    
    let bagroundImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "img-bg", in: BundleHelper.resolvedBundle, with: nil))
        img.layer.borderColor = UIColor.hexD2543.cgColor
        img.layer.borderWidth = 1
        //img.backgroundColor = .hex707070
        return img
    }()
    
    let leftArrowImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "left-arrow", in: BundleHelper.resolvedBundle, with: nil))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override func setup() {
        super.setup()
        addSubviews(bagroundImageView, leftArrowImg, ussdContentView)
        leftArrowImg.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, margin: .topLeftOnly(15, 15), size: .init(width: 25, height: 25))
        
        bagroundImageView.fillUpSuperview()
        ussdContentView.placeAtCenterIn(centerY: centerYAnchor, centerX: centerXAnchor, size: .init(width: Constant.screenWidth - 30, height: Constant.screenHeight * 0.5))
    }
}

