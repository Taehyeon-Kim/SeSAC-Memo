//
//  UILabel+.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/04.
//

import UIKit

extension UILabel {
    
    public func changeTextColor(of target: String, color: UIColor) {
        let text = text ?? ""
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: target)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        self.attributedText = attributedString
    }
}
