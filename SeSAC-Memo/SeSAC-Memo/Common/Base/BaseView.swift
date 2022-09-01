//
//  BaseView.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureAttributes()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAttributes() {}
    func configureLayout() {}
}
