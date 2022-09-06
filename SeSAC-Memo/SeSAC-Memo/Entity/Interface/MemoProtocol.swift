//
//  MemoProtocol.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import Foundation

protocol MemoProtocol {
    var title: String? { get set }
    var content: String? { get set }
    var createdAt: Date { get }
    var updatedAt: Date { get set }
    var pinned: Bool { get set }
}

extension MemoProtocol {
    var createdAt: Date {
        return Date()
    }
    
    var pinned: Bool {
        return false
    }
}
