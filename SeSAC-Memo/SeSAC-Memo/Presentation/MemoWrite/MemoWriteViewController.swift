//
//  MemoWriteViewController.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

final class MemoWriteViewController: UIViewController {
    
    private let rootView = MemoWriteView()
    
    private let memoWriteViewModel = MemoWriteViewModel()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        writeMemo()
    }
}

extension MemoWriteViewController {
    
    private func configureNavigationBar() {
        let doneItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(writeMemo))
        let shareItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = ColorFactory.shared.create(.primary)
        navigationItem.rightBarButtonItems = [doneItem, shareItem]
    }
    
    @objc private func writeMemo() {

        // nil 값일 때 저장 X
        guard let title = rootView.titleTextView.text,
              let content = rootView.contentTextView.text
        else { return }

        // 내용 없을 때 삭제하기 위함
        if title.isEmpty && (content.isEmpty || content.trimmingCharacters(in: .newlines).isEmpty) {
            // 내용 없음 - 삭제
            return
        }
        
        // 값이 각각 없는 경우가 있으면 nil로 저장하기 위함
        let newTitle: String? = title.isEmpty ? nil : title
        let newContent: String? = (content.isEmpty || content.trimmingCharacters(in: .newlines).isEmpty) ? nil : content
        
        let memo = MemoInterface(title: newTitle, content: newContent)
        memoWriteViewModel.write(memo)
    }
}
