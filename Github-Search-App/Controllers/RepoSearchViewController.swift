//
//  RepoSearchViewController.swift
//  Github-Search-App
//
//  Created by sanket kumar on 30/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class RepoSearchViewController: UITableViewController {
    
    fileprivate let searchBarController = UISearchController(searchResultsController: nil)
    fileprivate let cellId = "cellId"
    var timer : Timer?
    var gitRepos = [GitHubRepo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        setUpTabeView()
        
        setupAPICall(searchText: "movie")
        
    }
    
    
    
    fileprivate func setupAPICall(searchText: String) {
        let url = "https://api.github.com/search/repositories?q=\(searchText)&sort=watchers&order=desc"
        print("setupAPICall Called")
        APIServices.shared.fetchGitHubRepo(apiUrl: url) { (result) in
            
            switch result {
            case .success(let result):
                self.gitRepos = result.items!
                DispatchQueue.main.async {
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
            self.setupAPICall(searchText: searchText)
        })
    }
}
