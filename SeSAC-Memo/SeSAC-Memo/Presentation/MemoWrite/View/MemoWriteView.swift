//
//  MemoWriteView.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/04.
//

import UIKit

import SnapKit
import Then

final class MemoWriteView: BaseView {
    
    private let scrollView = UIScrollView()
    private lazy var containerStackView = UIStackView(arrangedSubviews: [titleTextView, contentTextView])
    let titleTextView = UITextView()
    let contentTextView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureAttributes() {
        backgroundColor = ColorFactory.shared.create(.background)
        
        containerStackView.do {
            $0.axis = .vertical
        }
        
        titleTextView.do {
            $0.backgroundColor = ColorFactory.shared.create(.background)
            $0.textColor = .label
            $0.font = .boldSystemFont(ofSize: 22)
            $0.isScrollEnabled = false
        }
        
        contentTextView.do {
            $0.backgroundColor = ColorFactory.shared.create(.background)
            $0.textColor = .label
            $0.font = .systemFont(ofSize: 17)
            $0.isScrollEnabled = false
        }
    }
    
    override func configureLayout() {
        addSubviews(scrollView)
        scrollView.addSubview(containerStackView)
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}
