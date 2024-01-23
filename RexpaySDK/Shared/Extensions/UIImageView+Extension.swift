//
//  UIImageView+Extension.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import UIKit
//import SDWebImage

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
	
	func showImage(url: String, placeHolderImage: UIImage? = nil, bgColor: UIColor = .lightGray, contentMode: UIImageView.ContentMode = .scaleAspectFit, completion: (() -> Void)? = nil) {
		clipsToBounds = true
		
        showLoader(on: self)
		
//		sd_setImage(with: URL(string: url), placeholderImage: placeHolderImage) { img, err, ds, _ in
//			DispatchQueue.main.async {
//				if err != nil {
//					if let placeHolderImage {
//						self.image = placeHolderImage
//						self.hideLoader(on: self)
//					} 
//	//				self.changeImageColor(to: .white)
//					self.backgroundColor = bgColor
//				}
//				else {
//					self.image = img
//					completion?()
//				}
//				self.contentMode = contentMode
//				self.hideLoader(on: self)
//			}
//		}
	}
    
    func changeImagegColor(to color: UIColor) {
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
    
    func changeImageColor(to color: UIColor) {
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
}
