//
//  UIButton+Extension.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import UIKit
//import SDWebImage

extension UIButton {
  
//  func showImage(imgUrl: String?) {
//    let url = URL(string: imgUrl ?? "")
//    sd_setBackgroundImage(with: url, for: .normal, placeholderImage: UIImage())
//  }
//    
//    func showImage(imgUrl: String?, _  completion: @escaping (_ done: Bool) -> Void) {
//      let url = URL(string: imgUrl ?? "")
//        sd_setBackgroundImage(with: url, for: .normal) { _, err, _, _ in
//            if err == nil {
//                completion(true)
//            }
//        }
//    }
}

enum ImagePosition {
	case left, right, top, bottom
}

extension UIButton {
	func disableButton() {
		self.isEnabled = false
	}
	
	func enableButton() {
		self.isEnabled = true
	}
}
