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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        setUpTabeView()
        setupAPICall()
        
    }
    
    var gitRepos = [GitHubRepo]()
    fileprivate func setupAPICall() {
        print("setupAPICall Called")
        let url = "https://api.github.com/search/repositories?q=podcast&sort=watchers&order=desc"
        APIServices.shared.fetchGitHubRepo(apiUrl: url) { (result) in
            
            switch result {
            case .success(let result):
                self.gitRepos = result.items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            default:
                return
            }
        }
    }
    
    
    fileprivate func setUpTabeView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let repo = self.gitRepos[indexPath.row]
        cell.textLabel?.text = repo.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}




extension RepoSearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
