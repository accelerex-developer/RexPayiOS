//
//  Button.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import Foundation
import UIKit

class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(btnTitle: String, btnTextColor: UIColor, btnBackgroundColor: UIColor, textFont: UIFont? = .poppinsBold(size: 16), cornerRadius: CGFloat? = 0) {
        self.init(frame: .zero)
        setTitle(btnTitle, for: .normal)
        setTitleColor(btnTextColor, for: .normal)
        backgroundColor = btnBackgroundColor
        titleLabel?.font = textFont
        layer.cornerRadius = cornerRadius ?? 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
