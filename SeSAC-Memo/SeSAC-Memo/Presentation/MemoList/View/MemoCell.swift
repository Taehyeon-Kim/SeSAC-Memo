//
//  MemoCell.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/02.
//

import UIKit
import SeSAC_Memo_UIKit
import SeSAC_Memo_Core

final class MemoCell: BaseTableViewCell {
    
    private lazy var containerVStackView = UIStackView(
        arrangedSubviews: [titleLabel, descriptionLabel]
    )
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override func configureAttributes() {
        backgroundColor = ThemeManager.currentTheme().cellBackgroundColor
        
        containerVStackView.do {
            $0.axis = .vertical
            $0.spacing = 4
        }
        
        titleLabel.do {
            $0.textColor = ThemeManager.currentTheme().titleTextColor
            $0.font = .boldSystemFont(ofSize: 17)
        }
        
        descriptionLabel.do {
            $0.textColor = ThemeManager.currentTheme().subtitleTextColor
            $0.font = .systemFont(ofSize: 15)
        }
    }
    
    override func configureLayout() {
        addSubviews(containerVStackView)
        
        containerVStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.trailing.leading.equalToSuperview().inset(20)
        }
    }
    
    override func prepareForReuse() {
        titleLabel.textColor = ThemeManager.currentTheme().titleTextColor
        descriptionLabel.textColor = ThemeManager.currentTheme().subtitleTextColor
    }
}

extension MemoCell {
    
    func configure(with data: Memo, isSearchMode: Bool = false, keyword: String? = nil) {
        let dateString = checkDateFormat(data.updatedAt)
        let title = data.title ?? "제목 없음"
        let content = data.content?.trimmingCharacters(in: .newlines) ?? "추가 텍스트 없음"
        
        titleLabel.text = "\(title)"
        descriptionLabel.text = "\(dateString) \(content)"
        
        let color = isSearchMode ?
        ThemeManager.currentTheme().pointColor : ThemeManager.currentTheme().titleTextColor
        titleLabel.changeTextColor(of: keyword ?? "", color: color)
        descriptionLabel.changeTextColor(of: keyword ?? "", color: color)
    }

    private func checkDateFormat(_ date: Date) -> String {
        var dateFormatType: DateFormatType = .fullWithHalfTime

        if Calendar.current.isDateInToday(date) {
            dateFormatType = .halfTime
        } else if Date.isDateInWeekday(date) {
            dateFormatType = .day
        } else {
            dateFormatType = .fullWithHalfTime
        }
        
        return DateFormatType.toString(date, to: dateFormatType)
    }
}
