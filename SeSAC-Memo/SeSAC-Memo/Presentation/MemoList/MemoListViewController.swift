//
//  MemoListViewController.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

final class MemoListViewController: BaseViewController {
   
    private let memoListViewModel = MemoListViewModel()
    
    private let rootView = MemoListView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchController()
        configureTableView()
        configureToolbar()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        memoListViewModel.fetchMemo()
    }
    
    override func configureAttributes() {
        view.backgroundColor = ColorFactory.shared.create(.background)
    }
}

extension MemoListViewController {
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func configureTableView() {
        self.rootView.tableView.delegate = self
        self.rootView.tableView.dataSource = self
    }
    
    private func configureToolbar() {
        self.rootView.writeHandler = {
            let memoWriteViewController = MemoWriteViewController()
            self.navigationController?.pushViewController(memoWriteViewController, animated: true)
        }
    }
    
    private func bind() {
        memoListViewModel.fetchMemo()
        
        memoListViewModel.memo.bind { _ in
            self.rootView.tableView.reloadData()
        }
        
        memoListViewModel.memoCount.bind { countString in
            self.navigationItem.title = countString
        }
    }
}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return memoListViewModel.titleForHeaderInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        return titleLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return memoListViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoListViewModel.numberOfRowsInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        memoListViewModel.cellForRowAt(tableView, indexPath: indexPath)
    }
}
