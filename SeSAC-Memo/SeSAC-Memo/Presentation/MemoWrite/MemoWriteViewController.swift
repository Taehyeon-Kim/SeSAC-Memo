//
//  MemoWriteViewController.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit
import SeSAC_Memo_UIKit

final class MemoWriteViewController: UIViewController {
    
    private let rootView = MemoWriteView()
    lazy var doneItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
    lazy var shareItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
    
    private let memoListViewModel = MemoListViewModel()
    let memoWriteViewModel = MemoWriteViewModel()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTextView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        writeMemo()
    }
    
    private func bind() {
        memoWriteViewModel.memo.bind { memo in
            self.rootView.titleTextView.text = memo.title
            self.rootView.contentTextView.text = memo.content
        }
        
        memoWriteViewModel.isWritingMode.bind { isWritingMode in
            if isWritingMode {
                self.configureNavigationBar()
                self.rootView.titleTextView.becomeFirstResponder()
            } else {
                self.navigationItem.setRightBarButton(nil, animated: true)
            }
        }
        
        memoWriteViewModel.isEditingMode.bind { isEditingMode in
            if isEditingMode {
                self.configureNavigationBar()
            } else {
                self.navigationItem.setRightBarButton(nil, animated: true)
            }
        }
    }
}

extension MemoWriteViewController {
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = ThemeManager.currentTheme().pointColor
        navigationItem.rightBarButtonItems = [doneItem, shareItem]
    }
    
    @objc private func doneButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func shareButtonTapped() {
        guard let title = rootView.titleTextView.text,
              let content = rootView.contentTextView.text
        else { return }

        let activityViewController = UIActivityViewController(activityItems: ["\(title)\n\n\(content)"], applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
    
    func writeMemo() {
        // nil 값일 때 저장 X
        guard let title = rootView.titleTextView.text,
              let content = rootView.contentTextView.text
        else { return }

        // 내용 없을 때 삭제하기 위함
        if title.isEmpty && (content.isEmpty || content.trimmingCharacters(in: .newlines).isEmpty) {
            if !memoWriteViewModel.isWritingMode.value {
                memoWriteViewModel.delete(memoWriteViewModel.memo.value)
            }
            return
        }
        
        // 값이 각각 없는 경우가 있으면 nil로 저장하기 위함
        let newTitle: String? = title.isEmpty ? nil : title
        let newContent: String? = (content.isEmpty || content.trimmingCharacters(in: .newlines).isEmpty) ? nil : content
        
        let memo = MemoInterface(title: newTitle, content: newContent)
        
        if memoWriteViewModel.isWritingMode.value {
            memoWriteViewModel.write(memo)
        } else {
            memoWriteViewModel.update(memoWriteViewModel.memo.value, newTitle: newTitle, newContent: newContent)
        }
    }
}

extension MemoWriteViewController: UITextViewDelegate {
    
    private func configureTextView() {
        rootView.titleTextView.delegate = self
        rootView.contentTextView.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" && textView == rootView.titleTextView {
            textView.resignFirstResponder()
            rootView.contentTextView.becomeFirstResponder()
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        memoWriteViewModel.isEditingMode.value = true
        textView.becomeFirstResponder()
    }
}
