//
//  PopUpViewController.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

final class PopUpViewController: BaseViewController {
    
    private let rootView = PopUpView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
