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
        backgroundColor = ColorFactory.shared.create(.darkGray)
        
        containerVStackView.do {
            $0.axis = .vertical
            $0.spacing = 4
        }
        
        titleLabel.do {
            $0.textColor = ColorFactory.shared.create(.white)
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
}

extension MemoCell {
    
    func configure(with data: Memo) {
        let dateString = checkDateFormat(data.updatedAt)
        let content = data.content ?? "추가 텍스트 없음"
        
        titleLabel.text = data.title
        descriptionLabel.text = "\(dateString) \(content)"
    }
    
    private func checkDateFormat(_ date: Date) -> String {
        var dateFormatType: DateFormatType = .fullWithHalfTime

        if Calendar.current.isDateInToday(date) {
            dateFormatType = .halfTime
        } else if isDateInWeekday(date) {
            dateFormatType = .day
        } else {
            dateFormatType = .fullWithHalfTime
        }
        
        return DateFormatType.toString(date, to: dateFormatType)
    }
    
    private func isDateInWeekday(_ date: Date) -> Bool {
        let currentWeekDay = Calendar.current.component(.weekday, from: Date()) - 1
        let startDate = Date().addingTimeInterval(TimeInterval(86400 * (1 - currentWeekDay)))
        let endDate = Date().addingTimeInterval(TimeInterval(86400 * (7 - currentWeekDay)))
        return clearTimeInDate(startDate)...clearTimeInDate(endDate) ~= date
    }
    
    private func clearTimeInDate(_ date: Date) -> Date {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 0))!
    }
}
