//
//  UICollectionView+Extension.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import UIKit

// MARK: - UICollectionView Extensions
extension UICollectionView {

    func setNoValuesFoundBackgroundMessage(_ message: String = "Data not found") {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        //messageLabel.textColor = .aLabel
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        //messageLabel.font = .avenirRegular(size: 15)
		messageLabel.textColor = .white
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func removeBackgroundView() {
        self.backgroundView = nil
    }
    
    func registerCellNib<Cell: UICollectionViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    func registerCell<Cell: UICollectionViewCell>(cellClass: Cell.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
    
    func estimatedTextFrame(text: String, font: UIFont, size: CGSize) -> CGRect {
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
        return estimatedFrame
    }
    
    func labelHeight(text: String, font: UIFont) -> CGRect {
        //let font = fio
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame
    }
    
    func getLabelSize(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
        let textHeight = attributedText.boundingRect(with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height.rounded(.up)
          return textHeight
      }
    
}

extension UICollectionViewCell {
    func labelSize(text: String, font: UIFont) -> CGRect {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame
    }
}

