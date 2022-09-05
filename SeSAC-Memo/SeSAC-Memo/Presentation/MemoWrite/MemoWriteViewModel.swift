//
//  MemoWriteViewModel.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/04.
//

import Foundation

final class MemoWriteViewModel {
    
    private let repository = MemoRepository()
    
    var memo = Observable(Memo())
    var title = Observable("")
    var content = Observable("")
    var isWritingMode = Observable(false)
    var isEditingMode = Observable(false)
    
    // 메모 저장
    func write(_ memo: MemoInterface) {
        repository.write(memo)
    }
    
    func update(_ memo: Memo, newTitle: String?, newContent: String?) {
        repository.update(memo) { memo in
            memo.title = newTitle
            memo.content = newContent
        }
    }
    
    func delete(_ memo: Memo) {
        repository.delete(memo)
    }
}
