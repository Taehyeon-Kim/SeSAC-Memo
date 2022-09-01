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
        case neutral    // white
        case neutral200
        case neutral400
        case neutral600
    }
    
    func create(_ style: ColorStyle) -> UIColor {
        switch style {
        case .primary:
            return .systemOrange
        case .delete:
            return .systemRed
        case .background:
            return .systemBackground
        case .neutral:
            return .white
        case .neutral200:
            return .systemGray6
        case .neutral400:
            return .systemGray4
        case .neutral600:
            return .systemGray2
        }
    }
}
