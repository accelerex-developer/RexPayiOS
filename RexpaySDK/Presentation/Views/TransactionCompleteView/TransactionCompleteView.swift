//
//  TransactionCompleteView.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

final class TransactionCompleteView: BaseView {
    
    let transactionCompleteContentView: TransactionCompleteContentView = {
        let view = TransactionCompleteContentView(scrollViewContentSize: .init(size: CGSize(width: Constant.screenWidth - 30, height: Constant.screenHeight * 0.5)))
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
    
    let cancelIcon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "cancel-icon-25", in: BundleHelper.resolvedBundle, with: nil))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    
    override func setup() {
        super.setup()
        
        print("Constant.screenHeight is \(Constant.screenHeight)")
        addSubviews(bagroundImageView, transactionCompleteContentView, cancelIcon)
        bagroundImageView.fillUpSuperview()
        transactionCompleteContentView.placeAtCenterIn(centerY: centerYAnchor, centerX: centerXAnchor, size: .init(width: Constant.screenWidth - 30, height: Constant.screenHeight * 0.5))
        cancelIcon.anchor(top: topAnchor, trailing: trailingAnchor, margin: .topRightOnly(30, 30), size: .init(width: 25, height: 25))
        
    }
}
