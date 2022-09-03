//
//  MemoListViewController.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

final class MemoListViewController: BaseViewController {
    
    private let repository = MemoRepository()
    
    private let rootView = MemoListView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureTableView()
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
        self.navigationItem.title = "Count"
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        self.rootView.tableView.delegate = self
        self.rootView.tableView.dataSource = self
    }
}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoCell.reuseIdentifier, for: indexPath) as? MemoCell else {
            return UITableViewCell()
        }
        
        // MemoProtocol을 채택하는 객체를 주입해주려고 하는데, 이게 맞는 방식인지 모르겠음.
        let memo: MemoProtocol = MemoInterface(
            title: "title",
            content: "content"
        )
        cell.configure(with: memo)
        
        return cell
    }
}
