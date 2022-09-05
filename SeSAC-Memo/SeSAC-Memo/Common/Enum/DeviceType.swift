//
//  DeviceType.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

enum DeviceType {
    case iPhone8
    case iPhone13Mini
    case iPhone13ProMax

    func name() -> String {
        switch self {
        case .iPhone8:
            return "iPhone 8 Plus"
        case .iPhone13Mini:
            return "iPhone 13 mini"
        case .iPhone13ProMax:
            return "iPhone 13 Pro max"
        }
    }
}
