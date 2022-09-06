//
//  MemoListView.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/02.
//

import UIKit
import SeSAC_Memo_UIKit
import SeSAC_Memo_Core

import SnapKit
import Then

final class MemoListView: BaseView {
    
    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let toolbar = UIToolbar(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: 100, height: 44)
        )
    )
    
    var writeHandler: (() -> Void)?
    
    override func configureAttributes() {
        tableView.do {
            $0.backgroundColor = .clear
            $0.register(MemoCell.self, forCellReuseIdentifier: MemoCell.reuseIdentifier)
            $0.keyboardDismissMode = .onDrag
        }
        
        toolbar.do {
            let writeItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: nil, action: #selector(writeItemTapped))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            $0.backgroundColor = ThemeManager.currentTheme().backgroundColor
            $0.tintColor = ThemeManager.currentTheme().pointColor
            $0.setItems([flexibleSpace, writeItem], animated: true)
        }
    }
    
    override func configureLayout() {
        addSubviews(tableView, toolbar)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        toolbar.snp.makeConstraints {
            $0.trailing.bottom.leading.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
    }
    
    @objc private func writeItemTapped() {
        writeHandler?()
    }
}
