//
//  MainBaseController.swift
//  GitRepos
//
//  Created by Abdullah on 02/01/2024.
//

import Foundation
import UIKit

class MainBaseController: UIViewController {
    
    let backArrowImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "back_arrow"))
        img.contentMode = .scaleAspectFit
        return img
    }() 
    
    let bookmarkImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "mdi_bookmark-outline"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let loaderContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()
    
    private let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView.init(style: .large)
        activity.startAnimating()
        return activity
    }()
    
    var backArrowHandler: (() -> Void)?
    var bookmarkHandler: (() -> Void)?
    
    func showNavbar() {
        navigationItem.setLeftBarButton(nil, animated: false)
        navigationItem.setRightBarButton(nil, animated: false)
        
        let backArrowNavItem = UIBarButtonItem.init(customView: backArrowImageView)
        navigationItem.setLeftBarButton(backArrowNavItem, animated: true)
        
        let bookmarkNavItem = UIBarButtonItem.init(customView: bookmarkImageView)
        navigationItem.setRightBarButton(bookmarkNavItem, animated: true)
        
        backArrowImageView.onClick(completion: weakify({ strongSelf in
            strongSelf.backArrowHandler?()
        }))
        
        bookmarkImageView.onClick(completion: weakify({ strongSelf in
            strongSelf.bookmarkHandler?()
        }))
    }
    
    func showLoader() {
        guard let keyWindow = UIWindow.keyWindow else { return }
        if keyWindow.subviews.contains(loaderContainer) {
            return
        }
        keyWindow.addSubview(loaderContainer)
        loaderContainer.anchor(top: keyWindow.topAnchor, leading: keyWindow.leadingAnchor, bottom: keyWindow.bottomAnchor, trailing: keyWindow.trailingAnchor)
        keyWindow.bringSubviewToFront(loaderContainer)
        
        loaderContainer.addSubview(activity)
        activity.placeAtCenterOf(centerY: loaderContainer.centerYAnchor, centerX: loaderContainer.centerXAnchor)
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            self.loaderContainer.removeFromSuperview()
        }
    }
    
    func showToastWithTitle(_ title: String?, type: ToastType, duration: TimeInterval = 1.0) {
        DispatchQueue.main.async {
            Toast.shared.showToastWithTitle(title ?? "Unable to complete this process, please try again", type: type, duration: duration)
        }
    }
}
