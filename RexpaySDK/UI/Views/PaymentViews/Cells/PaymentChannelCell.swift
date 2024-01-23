//
//  PaymentCell.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

final class PaymentChannelCell: BaseTableViewCell {
    
  
    
    let leftImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let rightImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let itemTitleLabel: Label = {
        let label = Label(text: "Pay with Card", font: .poppinsRegular(size: 14), textColor: .hex1A1A1A)
        return label
    }()
    
    override func setup() {
        super.setup()
        contentView.addSubviews(leftImgView, rightImgView, itemTitleLabel)
       
        leftImgView.placeAtLeftCenterOf(centerY: centerYAnchor, leading: leadingAnchor, size: .init(width: 24, height: 24))
        
        rightImgView.placeAtRightCenterOf(centerY: centerYAnchor, trailing: trailingAnchor, size: .init(width: 24, height: 24))
        
        itemTitleLabel.anchor(top: topAnchor, leading: leftImgView.trailingAnchor, bottom: bottomAnchor, trailing: rightImgView.leadingAnchor, margin: .sides(15, 15))
    }
    
    func updateCell(with data: PaymentChannelData) {
        leftImgView.image = UIImage(named: data.leftIcon, in: Bundle(for: PaymentChannelCell.self), with: nil)
        
        itemTitleLabel.text = data.title
        
        rightImgView.image = UIImage(named: data.rightIcon, in: Bundle(for: PaymentChannelCell.self), with: nil)
    }
}
