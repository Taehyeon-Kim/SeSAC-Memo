//
//  MemoPresentationModel.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/06.
//

import Foundation

final class MemoPresentationModel: MemoProtocol {
    var title: String?
    var content: String?
    var createdAt: Date
    var updatedAt: Date
    var pinned: Bool
    
    init(
        title: String?,
        content: String?,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        pinned: Bool = false
    ) {
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = createdAt
        self.pinned = pinned
    }
}
