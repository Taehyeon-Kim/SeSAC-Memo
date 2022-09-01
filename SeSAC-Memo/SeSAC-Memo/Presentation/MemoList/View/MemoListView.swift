//
//  MemoListView.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/02.
//

import UIKit

import SnapKit
import Then

final class MemoListView: BaseView {
    
    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func configureAttributes() {
        tableView.do {
            $0.backgroundColor = .clear
            $0.register(MemoCell.self, forCellReuseIdentifier: MemoCell.reuseIdentifier)
        }
    }
    
    override func configureLayout() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
