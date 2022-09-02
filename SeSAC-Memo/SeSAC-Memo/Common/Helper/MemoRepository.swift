//
//  MemoRepository.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/02.
//

import Foundation

import RealmSwift

protocol MemoCreatable {
    var count: Int { get }
    
    func printLocationOfDefaultRealm()
    func write(_ memo: MemoProtocol)
    func read() -> Results<Memo>
    func search(by keyword: String) -> Results<Memo>
    func update(_ memo: Memo, completion: ((Memo) -> Void)?)
    func delete(_ memo: Memo)
    func sort(by keyPath: String) -> Results<Memo>
}

struct MemoRepository: MemoCreatable {
    
    private var database = try! Realm()
}

extension MemoRepository {
    
    var count: Int {
        return database.objects(Memo.self).count
    }
    
    func printLocationOfDefaultRealm() {
        guard let location = database.configuration.fileURL else { return }
        print(location)
    }
    
    func write(_ memo: MemoProtocol) {
        let memo = Memo(memo: memo)
        
        do {
            try database.write {
                database.add(memo)
            }
        } catch let error {
            print(error)
        }
    }
    
    func read() -> Results<Memo> {
        return database.objects(Memo.self).sorted(byKeyPath: "updatedAt", ascending: false)
    }
    
    func search(by keyword: String) -> Results<Memo> {
        return database.objects(Memo.self).where {
            ($0.title.contains(keyword)) || ($0.content.contains(keyword))
        }
    }
    
    func update(_ memo: Memo, completion: ((Memo) -> Void)? = nil) {
        do {
            try database.write {
                database.create(Memo.self, value: memo, update: .modified)
            }
        } catch let error {
            print(error)
        }
    }
    
    func delete(_ memo: Memo) {
        return database.delete(memo)
    }
    
    func sort(by keyPath: String = "updatedAt") -> Results<Memo> {
        return database.objects(Memo.self).sorted(byKeyPath: keyPath, ascending: false)
    }
}
