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
    var isSearchMode = Observable(false)
    
    func titleForHeaderInSection(at section: Int, isSearchMode: Bool = false) -> String? {
        
        if memo.value[section].isEmpty {
            return nil
        }
        
        if memo.value.count == 1 {
            return isSearchMode ? "\(memo.value[section].count)개 찾음" : "메모"
            
        } else {
            if section == 0 {
                return memo.value[section].isEmpty ? nil : "고정된 메모"
                
            } else {
                return isSearchMode ? "\(memo.value[section].count)개 찾음" : "메모"
            }
        }
    }
    
    var numberOfSections: Int {
        return memo.value.count
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        return memo.value[section].count
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath, keyword: String? = nil) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoCell.reuseIdentifier, for: indexPath) as? MemoCell else {
            return UITableViewCell()
        }
        cell.configure(with: memo.value[indexPath.section][indexPath.row], isSearchMode: isSearchMode.value, keyword: keyword)
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
        
        memo.value.removeAll()
        if !pinned.isEmpty { memo.value.append(contentsOf: [pinned]) }
        memo.value.append(contentsOf: [notPinned])
        
        memoCount.value = "\(memo.value.flatMap { $0 }.count.toDecimal())개의 메모"
    }
    
    func deleteMemo(indexPath: IndexPath) {
        let memo = memo.value[indexPath.section][indexPath.row]
        self.memo.value[indexPath.section].remove(at: indexPath.row)
        repository.delete(memo)
    }
    
    func pinMemo(indexPath: IndexPath, handler: @escaping () -> Void) {
        let memo = memo.value[indexPath.section][indexPath.row]
        let pinnedMemo = self.memo.value.first
        
        if memo.pinned {
            repository.update(memo) { memo in
                memo.pinned.toggle()
            }
        } else {
            if pinnedMemo?.count ?? 0 >= 5 {
                handler()
            } else {
                repository.update(memo) { memo in
                    memo.pinned.toggle()
                }
            }
        }
    }
    
    func searchMemo(by keyword: String) {
        let allMemo = repository.search(by: keyword)
        
        var task: [Memo] = []
        allMemo.forEach { memo in
            task.append(memo)
        }
        
        memo.value.removeAll()
        memo.value.append(contentsOf: [task])
    }
}
