//
//  StackView.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView] = [], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .vertical
        self.distribution = distribution
        self.alignment = alignment
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HorizontalStack: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .horizontal
        self.distribution = distribution
        self.alignment = alignment
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIStackView {
    func show(_ view: UIView) {
        let index = subviews.count - 1
        insertArrangedSubview(view, at: index + 1)
        view.isHidden = false
    }
    
    func remove(_ view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
}
