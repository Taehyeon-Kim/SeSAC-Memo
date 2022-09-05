//
//  ColorFactory.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

final class ColorFactory {

    static let shared = ColorFactory()
    
    private init() {}
    
    enum ColorStyle {
        case primary
        case delete
        case background // white, black
        case white
        case grey200
        case grey800
        case darkGray
        case black
        case popUp
        case label
    }
    
    func create(_ style: ColorStyle) -> UIColor {
        switch style {
        case .primary:
            return .systemOrange
        case .delete:
            return .systemRed
        case .background:
            return .systemBackground
        case .white:
            return .white
        case .grey200:
            return .systemGray6
        case .grey800:
            return .systemGray
        case .darkGray:
            return .darkGray
        case .black:
            return .black
        case .popUp:
            return UIColor(named: "popUp")!
        case .label:
            return .label
        }
    }
}
