//
//  DateFormatType.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/03.
//

import Foundation

enum DateFormatType {
    case fullWithHalfTime
    case halfTime
    case day
}

extension DateFormatType {
    var format: String {
        switch self {
        case .fullWithHalfTime:
            return "yyyy. MM. dd a hh:mm"
        case .halfTime:
            return "a hh:mm"
        case .day:
            return "EEEE"
        }
    }
    
    static func toString(_ date: Date, to dateFormat: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = dateFormat.format
        return dateFormatter.string(from: date)
    }
}
