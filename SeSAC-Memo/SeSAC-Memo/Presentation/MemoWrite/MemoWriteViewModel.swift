//
//  MemoWriteViewModel.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/04.
//

import Foundation

final class MemoWriteViewModel {
    
    private let repository = MemoRepository()
    
    // 메모 저장
    func write(_ memo: MemoInterface) {
        repository.write(memo)
    }
}
