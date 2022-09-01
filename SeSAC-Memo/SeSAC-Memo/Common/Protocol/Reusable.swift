//
//  Reusable.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UIViewController: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
