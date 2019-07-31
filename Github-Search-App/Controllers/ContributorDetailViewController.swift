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
    fileprivate let infoCellId = "infoCellId"
    var repoContributor: RepoContributor?
    var repos = [GitHubRepo]()
    
    let tableViewHeader : UIView = {
        let header = UIView()
        header.backgroundColor = .green
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        print(repoContributor?.repos_url ?? "")
        fetchContributorRepos()
        navigationItem.title = repoContributor?.login ?? ""
    }
    
    fileprivate func fetchContributorRepos() {
        guard let contributor = repoContributor else { return }
        if let urlString = contributor.repos_url {
            APIServices.shared.fetchContributorRepos(urlString: urlString) { (result) in
                switch result {
                case .success(let result):
                    self.repos = result
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                default:
                    break;
                }
            }
        }
    }
    
    
    fileprivate func setUpTableView() {
        tableView.tableHeaderView = tableViewHeader
        tableView.tableFooterView = UIView()
        tableView.register(RepoViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ContributorInfoView.self, forCellReuseIdentifier: infoCellId)
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath) as! ContributorInfoView
            cell.repoContributor = self.repoContributor
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepoViewCell
            let gitHubRepo = repos[indexPath.row]
            cell.gitHubRepo = gitHubRepo
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return repos.count > 0 ? (indexPath.row == 0 ? 300 : 150) : 0
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
