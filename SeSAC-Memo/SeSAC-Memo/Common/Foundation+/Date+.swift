//
//  Date+.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/03.
//

import Foundation

extension Date {
    
    // 주 안에 날짜가 포함하는지 체크하기 위한 메서드
    static func isDateInWeekday(_ date: Date) -> Bool {
        let currentWeekDay = Calendar.current.component(.weekday, from: Date()) - 1
        let startDate = Date().addingTimeInterval(TimeInterval(86400 * (1 - currentWeekDay)))
        let endDate = Date().addingTimeInterval(TimeInterval(86400 * (7 - currentWeekDay)))
        return startDate.clearTimeInDate()...endDate.clearTimeInDate() ~= date
    }
    
    // 시, 분, 초 모두 0으로 맞추기 위한 메서드
    func clearTimeInDate() -> Date {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 0))!
    }
}
