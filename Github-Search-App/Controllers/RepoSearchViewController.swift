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
    
    fileprivate let searchBarController = UISearchController(searchResultsController: nil)
    fileprivate let cellId = "cellId"
    var timer : Timer?
    var gitRepos = [GitHubRepo]()

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
                    self.gitRepos = items
                }
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                    self.tableView.reloadData()
                }
            default:
                return
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
    }
    
    @objc fileprivate func handleFilter() {
        print("Filter search result")
        showActionSheet()
    }
    
    fileprivate func showActionSheet() {
        let alertController = UIAlertController(title: "Sort", message: "Sort the result by Wathers Count or Name", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Sort by Wathers Count", style: .default, handler: { (_) in
            self.sortGitRepoByWatcherCount()
        }))
        
        alertController.addAction(UIAlertAction(title: "Sort by name", style: .default, handler: { (_) in
            self.sortGitRepoByName()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alertController, animated: true)
    }
    
    fileprivate func sortGitRepoByWatcherCount() {
        let sortedRepo = self.gitRepos.sorted { (repo1, repo2) -> Bool in
            if let wCount1 = repo1.watchers , let wCount2 = repo2.watchers {
                return wCount1 > wCount2
            }
            return false
        }
        self.gitRepos = sortedRepo
        self.tableView.reloadData()
    }
    
    fileprivate func sortGitRepoByName() {
        let sortedRepo = self.gitRepos.sorted { (repo1, repo2) -> Bool in
            if let wName1 = repo1.name , let wName2 = repo2.name {
                return wName1 < wName2
            }
            return false
        }
        self.gitRepos = sortedRepo
        self.tableView.reloadData()
    }
    
    
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitRepos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepoViewCell
        cell.gitHubRepo = self.gitRepos[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return gitRepos.count > 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter a search term."
        label.textAlignment = .center
        label.textColor = .purple
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return gitRepos.count > 0 ? 0 : 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let repoDetailViewController = RepoDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
        repoDetailViewController.gitRepo = self.gitRepos[indexPath.row]
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
