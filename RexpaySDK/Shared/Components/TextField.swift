//
//  TextField.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import Foundation
import UIKit

//final class BPTextField: UIView {
//    
//    
//    private let messageLabel: Label =  {
//        let label = Label(text: "", font: .poppinsRegular(size: 13), textColor: .hex4B4651)
//        return label
//    }()
//    
//    private lazy var alertIcon: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "alert_icon_2"))
//        imageView.accessibilityIdentifier = "Alert icon 2"
//        return imageView
//    }()
//    
//    var field: TextField = {
//        let textField = TextField()
////        textField.layer.borderWidth = 1
////        textField.layer.cornerRadius = 7
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.cornerRadius = 3
//        textField.font = .poppinsBold(size: 14)
//        textField.textColor = .hex707070
//        textField.layer.borderColor = UIColor.hexDADADA.cgColor
//        textField.backgroundColor = .white
//        return textField
//    }()
//    
//    var unWrappedText: String {
//        if let text = field.text {
//            return text
//        }
//        return ""
//    }
//    
//    private var fieldBorderColor: CGColor? {
//        didSet {
//            field.layer.borderColor = fieldBorderColor ?? UIColor.lightGray.withAlphaComponent(0.3).cgColor
//            field.applyShadow(shadowColor: fieldBorderColor ?? UIColor.lightGray.withAlphaComponent(0.3).cgColor)
//            field.textColor = .black
//        }
//    }
//    
//    private var placeHolder: String?
//    private var hasIcon: Bool?
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    convenience init(title: String, textColor: UIColor? = .hex4B4651, font: UIFont =  .poppinsRegular(size: 13), placeHolder: String, hasIcon: Bool = false) {
//        self.init(frame: .zero)
//        messageLabel.text = title
//        messageLabel.textColor = textColor
//        messageLabel.font = font
//        self.field.placeholder = placeHolder
//        self.hasIcon = hasIcon
//        setup()
//    }
//    
//    private func setup() {
//        let container = UIView()
//        addSubview(container)
//        container.fillUpSuperview()
//        container.addSubviews(messageLabel,field)
//        messageLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 13))
//   
//        field.anchor(top: messageLabel.bottomAnchor, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor, margin: .topOnly(10))
//        
//        if hasIcon ?? false {
////            field.rightViewMode = .always
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//            let image = UIImage(named: "down_arrow_icon")
//            imageView.image = image
//            imageView.contentMode = .center
////            imageView.insec
////            field.rightView = imageView
//            field.addSubview(imageView)
//            imageView.placeAtRightCenterOf(centerY: field.centerYAnchor, trailing: field.trailingAnchor, margin: .rightOnly(15), size: .init(width: 20, height: 20))
//        }
//        
//    }
//    
//}
//
//class TextField: UITextField {
//
//    var padding: UIEdgeInsets = .sides(20, 10)
//
//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//}

