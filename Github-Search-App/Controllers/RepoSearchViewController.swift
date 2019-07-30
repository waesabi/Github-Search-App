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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpSearchBar()
        
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
    

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
}


extension RepoSearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
