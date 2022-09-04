//
//  MemoWriteViewController.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

final class MemoWriteViewController: UIViewController {
    
    private let rootView = MemoWriteView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
}

extension MemoWriteViewController {
    
    private func configureNavigationBar() {
        let doneItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: nil)
        let shareItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = ColorFactory.shared.create(.primary)
        navigationItem.rightBarButtonItems = [doneItem, shareItem]
    }
}
