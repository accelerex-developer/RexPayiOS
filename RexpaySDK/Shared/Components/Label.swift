//
//  Label.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import UIKit

class Label: UILabel {

    private var insets = UIEdgeInsets(allEdges: 0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + insets.left + insets.right, height: originalSize.height + insets.top + insets.bottom)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .poppinsRegular(size: 13)
    }
    
    init(padding: UIEdgeInsets = .init(allEdges: 0), alignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        self.numberOfLines = 0
        self.textAlignment = alignment
        self.insets = padding
        self.lineBreakMode = .byWordWrapping
    }
    
    init(text: String, font: UIFont, numberOfLines: Int = 0, textColor: UIColor = .black, alignment: NSTextAlignment = .left, underlined: Bool = false, padding: UIEdgeInsets = .init(allEdges: 0), letterSpacing: CGFloat = 0, lineBreakMode: NSLineBreakMode = .byWordWrapping) {
        super.init(frame: .zero)
        self.font = font
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.insets = padding
        self.lineBreakMode = lineBreakMode
        //self.adjustsFontSizeToFitWidth = true
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
        
        if underlined {
            underline()
        }
        
    }
    
    init(attributedText: NSAttributedString, numberOfLines: Int = 0, alignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        self.attributedText = attributedText
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UILabel {
    func setLineHeight(spacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
    
    func cross(){
        let attr: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
        attr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attr.length))
        attributedText = attr
    }
    
    func underline(){
        let attr: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
        attr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attr.length))
        attributedText = attr
    }
}

extension Dictionary {
    var isNotEmpty: Bool {
        isEmpty ? false : true
    }
}
