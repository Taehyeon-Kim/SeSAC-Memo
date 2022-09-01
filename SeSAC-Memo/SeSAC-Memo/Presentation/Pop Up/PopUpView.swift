//
//  PopUpView.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

import SnapKit
import Then

final class PopUpView: BaseView {
    
    private let dimmedView = UIView()
    private let containerView = UIView()
    private let messageLabel = UILabel()
    private let confirmButton = UIButton()
    
    private let colorFactory = ColorFactory.shared
    
    override func configureAttributes() {
        dimmedView.do {
            $0.alpha = 0.5
            $0.backgroundColor = colorFactory.create(.black)
        }
        
        containerView.do {
            $0.backgroundColor = colorFactory.create(.darkGray)
            $0.layer.cornerRadius = 8
        }
        
        messageLabel.do {
            $0.numberOfLines = 0
            $0.text = """
            처음 오셨군요!
            환영합니다"
            
            당신만의 메모를 작성하고
            관리해보세요!
            """
            $0.textColor = colorFactory.create(.white)
            $0.font = .boldSystemFont(ofSize: 18)
        }
        
        confirmButton.do {
            $0.backgroundColor = colorFactory.create(.primary)
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(colorFactory.create(.white), for: .normal)
            $0.layer.cornerRadius = 8
        }
    }
    
    override func configureLayout() {
        self.addSubviews(dimmedView, containerView)
        containerView.addSubviews(messageLabel, confirmButton)
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.center.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview().inset(20)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(messageLabel.snp.bottom).offset(8)
            $0.trailing.bottom.leading.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
    }
}
