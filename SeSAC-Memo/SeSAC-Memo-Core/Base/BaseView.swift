//
//  BaseView.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

open class BaseView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        configureAttributes()
        configureLayout()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configureAttributes() {}
    open func configureLayout() {}
}
