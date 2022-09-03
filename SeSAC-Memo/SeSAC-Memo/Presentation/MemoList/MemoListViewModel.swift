//
//  MemoListViewModel.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/02.
//

import Foundation

import RealmSwift
import SwiftUI

final class MemoListViewModel {
    
    private let repository = MemoRepository()
    
    var memo: Observable<[[Memo]]> = Observable([])
    var memoCount = Observable("메모 개수")
    

    func titleForHeaderInSection(at section: Int) -> String? {
        if memo.value.count == 1 {
            return "메모"
            
        } else {
            if section == 0 {
                return memo.value[section].isEmpty ? nil : "고정된 메모"
                
            } else {
                return "메모"
            }
        }
    }
    
    var numberOfSections: Int {
        return memo.value.count
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        return memo.value[section].count
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoCell.reuseIdentifier, for: indexPath) as? MemoCell else {
            return UITableViewCell()
        }
        cell.configure(with: memo.value[indexPath.section][indexPath.row])
        return cell
    }
}

extension MemoListViewModel {
    
    func fetchMemo() {
        let allMemo = repository.fetch()
        
        var task: [Memo] = []
        allMemo.forEach { memo in
            task.append(memo)
        }
        
        let pinned = task.filter { $0.pinned == true }
        let notPinned = task.filter { $0.pinned == false }
        
        if !pinned.isEmpty { memo.value.append(contentsOf: [pinned]) }
        memo.value.append(contentsOf: [notPinned])
        
        memoCount.value = "\(memo.value.flatMap { $0 }.count.toDecimal())개의 메모"
    }
}
