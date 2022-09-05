//
//  MemoCell.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/02.
//

import UIKit

final class MemoCell: BaseTableViewCell {
    
    private lazy var containerVStackView = UIStackView(
        arrangedSubviews: [titleLabel, descriptionLabel]
    )
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override func configureAttributes() {
        backgroundColor = ColorFactory.shared.create(.cellBackground)
        
        containerVStackView.do {
            $0.axis = .vertical
            $0.spacing = 4
        }
        
        titleLabel.do {
            $0.textColor = ColorFactory.shared.create(.label)
            $0.font = .boldSystemFont(ofSize: 17)
        }
        
        descriptionLabel.do {
            $0.textColor = ColorFactory.shared.create(.grey800)
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
        titleLabel.textColor = ColorFactory.shared.create(.label)
        descriptionLabel.textColor = ColorFactory.shared.create(.label)
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
        ColorFactory.shared.create(.primary) : ColorFactory.shared.create(.label)
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
