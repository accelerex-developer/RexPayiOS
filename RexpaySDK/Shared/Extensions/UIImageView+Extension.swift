//
//  UIImageView+Extension.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import UIKit
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
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
