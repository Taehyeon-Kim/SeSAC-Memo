//
//  Memo.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import Foundation

import RealmSwift

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
