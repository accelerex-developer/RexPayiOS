//
//  UIview+Extension.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    var containerContentSize: CGSize {
        let contentRect: CGRect = self.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        printContent("contentRect.size is \(contentRect.size)")
        return contentRect.size
    }
    
    func showLoader(on view: UIView, activityColor: UIColor = .clear) {
        let activity = UIActivityIndicatorView.init(style: .medium)
        view.addSubview(activity)
        activity.placeAtCenterOf(centerY: view.centerYAnchor, centerX: view.centerXAnchor)
        activity.startAnimating()
        //activity.color = activityColor
    }
    
    func hideLoader(on view: UIView) {
        for el in view.subviews {
            if el.isKind(of: UIActivityIndicatorView.self) {
                let activity = el as! UIActivityIndicatorView
                activity.hidesWhenStopped = true
                activity.stopAnimating()
            }
        }
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        layer.maskedCorners = corners
        layer.cornerRadius = radius
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 10.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
        
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
//
//    func roundCorners(at corner: UIRectCorner, radius: CGFloat) {
//        let rectShape = CAShapeLayer()
//        rectShape.bounds = frame
//        rectShape.position = center
//        rectShape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius)).cgPath
//        layer.backgroundColor = UIColor.green.cgColor
//        //Here I'm masking the textView's layer with rectShape layer
//        layer.mask = rectShape
//    }
    
    func applyShadow(radius: CGFloat = 2, shadowOpacity: Float = 0.8, shadowOffset: CGSize = .zero, shadowColor: CGColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.09).cgColor){
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = radius
        layer.shadowOffset = shadowOffset
    }
    
    func onClick(completion: (() -> Void)? = nil) {
       addTapGesture {
           completion?()
       }
   }
    
    func addTapGesture(action: @escaping () -> Void ){
        let tap = BindableGestureRecognizer(action: action)
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
}

final class BindableGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }
    
    @objc private func execute() {
        action()
    }
}
