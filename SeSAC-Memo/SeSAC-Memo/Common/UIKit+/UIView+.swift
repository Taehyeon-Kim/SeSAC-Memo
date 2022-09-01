//
//  UIView+.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
