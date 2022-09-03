//
//  Observable.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/03.
//

import Foundation

final class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completion: @escaping((T) -> Void)) {
        completion(value)
        listener = completion
    }
}
