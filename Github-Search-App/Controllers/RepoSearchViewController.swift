//
//  RepoSearchViewController.swift
//  Github-Search-App
//
//  Created by sanket kumar on 30/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import ProgressHUD

class RepoSearchViewController: UITableViewController {
    
    
    // ViewModel
    var repoListViewModel: RepoListViewModel?
    
    
    fileprivate let searchBarController = UISearchController(searchResultsController: nil)
    fileprivate let cellId = "cellId"
    var timer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchBar()
        setUpTabeView()
        
        setupAPICall(searchedText: "movie")
    }
    
    fileprivate func setupAPICall(searchedText: String) {
        print("setupAPICall Called")
        ProgressHUD.show("Loading...")
        APIServices.shared.searchGitRepo(searchedRepo: searchedText) { (result) in
            
            switch result {
            case .success(let result):
                if let items = result.items {
                    self.repoListViewModel = RepoListViewModel(gitHubRepoList: items)
                }
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                    self.tableView.reloadData()
                   self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    ProgressHUD.showError(error.localizedDescription)
                }
            }
        }
    }
    
    
    fileprivate func setUpTabeView() {
        tableView.tableFooterView = UIView()
        tableView.register(RepoViewCell.self, forCellReuseIdentifier: cellId)
    }
    

    fileprivate func setUpSearchBar() {
        navigationItem.title = "GitRepo"
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBarController.dimsBackgroundDuringPresentation = false
        searchBarController.searchBar.delegate = self
    
        setupBarButtonItem()
    }
    
    fileprivate func setupBarButtonItem() {
        let filterButton = UIButton(type: .system)
        filterButton.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filterButton.addTarget(self, action: #selector(handleFilter), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc fileprivate func handleFilter() {
        showActionSheet()
    }
    
    fileprivate func showActionSheet() {
        let alertController = UIAlertController(title: "Sort", message: "Sort the result by Watchers Count or Name", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Sort by Watchers Count", style: .default, handler: { (_) in
            self.sortGitRepoByWatcherCount()
        }))
        
        alertController.addAction(UIAlertAction(title: "Sort by name", style: .default, handler: { (_) in
            self.sortGitRepoByName()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alertController, animated: true)
    }
    
    fileprivate func sortGitRepoByWatcherCount() {
        self.repoListViewModel?.sortByWatchersCount()
        self.tableView.reloadData()
    }
    
    fileprivate func sortGitRepoByName() {
        self.repoListViewModel?.sortByName()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoListViewModel?.numberOfRepos ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepoViewCell
        if let viewModel = self.repoListViewModel {
            cell.repoViewModel = RepoViewModel(gitRepo: viewModel.gitHubRepo(for: indexPath.row))
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.repoListViewModel?.numberOfRepos ?? 0) > 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please search any github repo."
        label.textAlignment = .center
        label.textColor = .purple
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (self.repoListViewModel?.numberOfRepos ?? 0) > 0 ? 0 : 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let repoDetailViewController = RepoDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
//        repoDetailViewController.gitRepo = self.repoListViewModel?.gitHubRepo(for: indexPath.row)
        if let repoList = self.repoListViewModel {
            repoDetailViewController.repoViewModel = RepoViewModel(gitRepo: repoList.gitHubRepo(for: indexPath.row))
        }
        navigationController?.pushViewController(repoDetailViewController, animated: true)
    }
    
}

extension RepoSearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.setupAPICall(searchedText: searchText)
        })
    }
}
