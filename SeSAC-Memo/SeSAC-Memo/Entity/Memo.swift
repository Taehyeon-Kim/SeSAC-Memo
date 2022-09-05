//
//  Memo.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import Foundation

import RealmSwift

final class MemoInterface: MemoProtocol {
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

final class Memo: Object, MemoProtocol {

    @Persisted var title: String?
    @Persisted var content: String?
    @Persisted var createdAt = Date()
    @Persisted var updatedAt = Date()
    @Persisted var pinned: Bool
    
    @Persisted(primaryKey: true) var objectID: ObjectId

    convenience init(memo: MemoProtocol) {
        self.init()
        
        title = memo.title
        content = memo.content
        createdAt = memo.createdAt
        updatedAt = memo.updatedAt
        pinned = memo.pinned
    }
}
