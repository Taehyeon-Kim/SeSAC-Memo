//
//  WelcomeViewController.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

import SeSAC_Memo_Core

final class WelcomeViewController: BaseViewController {
    
    private let rootView = WelcomeView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    @objc func confirmButtonTapped() {
        dismiss(animated: true)
    }
}
