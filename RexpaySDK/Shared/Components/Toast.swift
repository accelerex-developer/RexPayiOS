//
//  Toast.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import Foundation
import UIKit

public enum ToastType{
    case success,error,processing
}

final public class Toast: UIView {
    
    lazy var titleLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "test test"
        textLabel.font = .poppinsBold(size: 15)
        textLabel.textColor = .white
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 3
        return textLabel
    }()
    
    

    var type:ToastType = .success{
        didSet{
            switch (type) {
            case .error:
                backgroundColor = .hexEE4848
                break
            case .success:
                backgroundColor = .hex00ab80
                break
            case .processing:
                backgroundColor = .hexd49426
                break
            }
        }
    }
    
    static var shared = Toast()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(titleLabel)
//        companyBrandIcon.anchor(bottom: bottomAnchor, trailing: trailingAnchor, margin: .bottomRightOnly(7, 3), size: .init(width: 20, height: 20))
        
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .init(top: 3, left: 20, bottom: 0, right: 5))
        
        self.isUserInteractionEnabled = true
        
        roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 3)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        applyShadow()
    }
    
    func closeToast(duration: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.beginHideToast(duration: duration)
        }
    }
    
    private func beginHideToast(duration: TimeInterval){
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = .init(translationX: 0, y: -200)
        }, completion: nil)
    }
    
    func showToastWithTitle(_ title: String?, type: ToastType, duration: TimeInterval = 1.0) {
        Constant.lightHaptic()
        self.type = type
        self.titleLabel.text = title
        guard let window = UIWindow.keyWindow else {return}
        window.addSubview(self)
        window.bringSubviewToFront(self)
        
        self.anchor(top: window.topAnchor, leading: window.leadingAnchor, bottom: nil, trailing: window.trailingAnchor, margin: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: Constant.statusBarFrameHeight + 50))
        
        self.transform = .init(translationX: 0, y: -200)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = .identity
        }, completion: nil)
        closeToast(duration: duration)
    }
    
    func show(_ title: String, type: ToastType = .success) {
        Constant.lightHaptic()
        
        self.type = type
        self.titleLabel.text = title
        
        guard let window = UIWindow.keyWindow else { return }
        
        window.addSubview(self)
        window.bringSubviewToFront(self)
        
        self.anchor(top: window.topAnchor, leading: window.leadingAnchor, bottom: nil, trailing: window.trailingAnchor, margin: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: Constant.statusBarFrameHeight + 50))
        
        self.transform = .init(translationX: 0, y: -200)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [], animations: {
            self.transform = .identity
        }, completion: nil)
        
        //closeToast()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
