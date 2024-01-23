//
//  BaseView.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import Foundation
import UIKit

class BaseView: UIView {

    let customNavHeight = Constant.statusBarFrameHeight + 55 + 20
    
    func setup(){
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
    }

    func layout() {}
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearAll() {
        subviews.forEach{ $0.removeFromSuperview() }
    }
}

class BaseCollectionView: UICollectionView {
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    public convenience init(direction: UICollectionView.ScrollDirection = .vertical){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        self.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseCollectionViewCell: UICollectionViewCell {
    func setup(){
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseTableViewCell: UITableViewCell,
                              UITextFieldDelegate {
    
    func setup(){
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ScrollViewContentSize {
    var size: CGSize = .init(width: Constant.screenWidth, height: Constant.screenHeight)
    init(size: CGSize) {
        self.size = size
        print("contentViewSize dfd is \(size)")
    }
}

class ScrollableView<T: ScrollViewContentSize>: BaseView {

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width:  scrollViewContentSize.size.width, height: scrollViewContentSize.size.height)
        view.contentSize = contentViewSize
        view.showsVerticalScrollIndicator = false
        return view
    }()

    lazy var container: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.frame.size = contentViewSize
        return v
    }()

    lazy var contentViewSize = CGSize(width: scrollViewContentSize.size.width, height: scrollViewContentSize.size.height)
    var scrollViewContentSize: T

    init(scrollViewContentSize: T) {
        print("Init 1")
        self.scrollViewContentSize = scrollViewContentSize
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.addSubview(container)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateContentHeight()
    }
    
    func updateContentHeight() {
        var totalHeight: CGFloat = 0.0
        for subview in container.subviews {
            print("subview.frame.size lala is \(subview.frame)")
            if subview.frame.size.height > 0 {
                totalHeight += subview.frame.size.height
                print("output is \(totalHeight)")
            }
        }
        if totalHeight > 0 {
            print("total height is \(totalHeight)")
            scrollView.contentSize.height = totalHeight + 200
            container.frame.size.height = totalHeight + 200
        }
    }
}
