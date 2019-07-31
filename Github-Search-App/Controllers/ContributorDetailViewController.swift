//
//  ContributorDetailViewController.swift
//  Github-Search-App
//
//  Created by sanket kumar on 31/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class ContributorDetailViewController: UITableViewController {
    
    fileprivate let cellId = "cellId"
    var repoContributor: RepoContributor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabeView()
        print(repoContributor?.repos_url ?? "")
    }
    
    
    fileprivate func setUpTabeView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
}
