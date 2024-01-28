//
//  PaymentFootView.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit

final class PaymentFooterView: BaseView {
    
    
    let accelerexLogoImgView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "Accelerex-logo-png", in: Bundle(for: PaymentFooterView.self), with: nil))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override func setup() {
        super.setup()
        
        addSubview(accelerexLogoImgView)
        
        accelerexLogoImgView.placeAtCenterOf(centerY: centerYAnchor, centerX: centerXAnchor)
        
    }
}
