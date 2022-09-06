//
//  BaseTableViewCell.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureAttributes()
        configureLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configureAttributes() {}
    open func configureLayout() {}
}
