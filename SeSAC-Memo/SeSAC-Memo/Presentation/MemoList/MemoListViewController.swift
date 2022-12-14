//
//  MemoListViewController.swift
//  SeSAC-Memo
//
//  Created by taekki on 2022/09/01.
//

import UIKit

import SeSAC_Memo_Core
import SeSAC_Memo_UIKit

final class MemoListViewController: BaseViewController {
   
    // MARK: - Properties
    
    private let memoListViewModel = MemoListViewModel()
    private let theme = ThemeManager.currentTheme()
    
    // MARK: - UI Properties
    
    private let rootView = MemoListView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        checkForFirstLaunch()
        checkIfSearchMode()
    }
    
    // MARK: - Override Functions
    
    override func configureAttributes() {
        view.backgroundColor = theme.backgroundColor
        
        configureSearchController()
        configureTableView()
        configureToolbar()
    }
}

// MARK: - Private Functions

extension MemoListViewController {
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.tintColor = theme.pointColor
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    
    private func configureTableView() {
        self.rootView.tableView.delegate = self
        self.rootView.tableView.dataSource = self
    }
    
    private func configureToolbar() {
        self.rootView.writeHandler = { [weak self] in
            self?.transition(MemoWriteViewController(), transitionStyle: .push) { viewController in
                viewController.memoWriteViewModel.isWritingMode.value = true
            }
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
        
        memoListViewModel.isSearching.bind { isSearchMode in
            let backButton = UIBarButtonItem()
            var backButtonTitle = ""
            
            if isSearchMode {
                self.memoListViewModel.searchMemo(by: self.memoListViewModel.searchKeyword.value)
                backButtonTitle = "검색"
                
            } else {
                self.memoListViewModel.fetchMemo()
                backButtonTitle = "메모"
            }
            
            backButton.title = backButtonTitle
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            self.rootView.tableView.reloadData()
        }
    }
    
    func checkForFirstLaunch() {
        let isFirstLaunch = UserDefaults.standard.object(forKey: "isFirstLaunch")
        
        if isFirstLaunch == nil || isFirstLaunch as? Bool == true {
            self.transition(WelcomeViewController(), transitionStyle: .presentCrossDisolve)
        }
        
        UserDefaults.standard.set(false, forKey: "isFirstLaunch")
    }
    
    func checkIfSearchMode() {
        if self.memoListViewModel.isSearching.value {
            self.memoListViewModel.searchMemo(by: self.memoListViewModel.searchKeyword.value)
        } else {
            self.memoListViewModel.fetchMemo()
        }
    }
}

// MARK: - UITableViewDelegate

extension MemoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return memoListViewModel.titleForHeaderInSection(at: section, isSearchMode: memoListViewModel.isSearching.value)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memoWriteViewController = MemoWriteViewController()
        let memo = memoListViewModel.memo.value[indexPath.section][indexPath.row]
        memoWriteViewController.memoWriteViewModel.title.value = memo.title ?? ""
        memoWriteViewController.memoWriteViewModel.content.value = memo.content ?? ""
        memoWriteViewController.memoWriteViewModel.isWritingMode.value = false
        memoWriteViewController.memoWriteViewModel.memo.value = memo
        self.navigationController?.pushViewController(memoWriteViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pinAction = UIContextualAction(style: .normal, title: nil) { _, _, completionHaldler in
            self.memoListViewModel.pinMemo(indexPath: indexPath) {
                self.presentAlert(title: "메모는 최대 5개까지 고정할 수 있어요!")
            }
            self.checkIfSearchMode()
            completionHaldler(true)
        }
        
        let memo = memoListViewModel.memo.value[indexPath.section][indexPath.row]
        pinAction.backgroundColor = ThemeManager.currentTheme().pointColor
        pinAction.image = memo.pinned ? .icnPinFill : .icnPin
        return UISwipeActionsConfiguration(actions: [pinAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completionHaldler in
            self.presentAlert(title: "정말로 삭제하실건가요?", isIncludedCancel: true) { _ in
                self.memoListViewModel.deleteMemo(indexPath: indexPath)
                self.checkIfSearchMode()
            }
            completionHaldler(true)
        }
        deleteAction.image = .icnDelete
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - UITableViewDataSource

extension MemoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return memoListViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoListViewModel.numberOfRowsInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        memoListViewModel.cellForRowAt(tableView, indexPath: indexPath, keyword: navigationItem.searchController?.searchBar.text)
    }
}

// MARK: - UISearchBarDelegate

extension MemoListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        memoListViewModel.isSearching.value = true
        guard let keyword = searchBar.text else { return }
        memoListViewModel.searchKeyword.value = keyword
        memoListViewModel.searchMemo(by: keyword)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        guard let keyword = searchBar.text else { return true }
        memoListViewModel.searchKeyword.value = keyword
        
        if keyword == "" {
            memoListViewModel.fetchMemo()
        } else {
            memoListViewModel.searchMemo(by: keyword)
        }
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        memoListViewModel.isSearching.value = false
        memoListViewModel.fetchMemo()
    }
}
