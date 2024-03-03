//
//  MainBaseController.swift
//  GitRepos
//
//  Created by Abdullah on 02/01/2024.
//

import UIKit
import Combine

class MainBaseController: UIViewController {
    var subscriptions: Set<AnyCancellable> = []
//    let backArrowImageView: UIImageView = {
//        let img = UIImageView(image: UIImage(named: "back_arrow"))
//        img.contentMode = .scaleAspectFit
//        return img
//    }() 
//    
//    let bookmarkImageView: UIImageView = {
//        let img = UIImageView(image: UIImage(named: "mdi_bookmark-outline"))
//        img.contentMode = .scaleAspectFit
//        return img
//    }()
    
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
