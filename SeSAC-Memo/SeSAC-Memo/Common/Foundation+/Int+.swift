//
//  Int+.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/03.
//

import Foundation

extension Int {
    
    func toDecimal() -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: self) ?? "\(self)"
    }
}
