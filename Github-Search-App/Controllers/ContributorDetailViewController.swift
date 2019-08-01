//
//  ContributorDetailViewController.swift
//  Github-Search-App
//
//  Created by sanket kumar on 31/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import ProgressHUD

class ContributorDetailViewController: UITableViewController {
    
    
    fileprivate let cellId = "cellId"
    fileprivate let infoCellId = "infoCellId"
    var repoContributor: RepoContributor?
    
    // ViewModel
    var repoListViewModel: RepoListViewModel?
    var repoContributorViewModel: ContributorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        fetchContributorRepos()
        navigationItem.title = repoContributorViewModel?.login ?? ""
    }
    
    fileprivate func fetchContributorRepos() {
        if let viewModel = repoContributorViewModel {
            let urlString = viewModel.reposUrl
            ProgressHUD.show("Loading...")
            APIServices.shared.fetchContributorRepos(urlString: urlString) { (result) in
                switch result {
                case .success(let result):
                    self.repoListViewModel = RepoListViewModel(gitHubRepoList: result)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        ProgressHUD.dismiss()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        ProgressHUD.showError(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    fileprivate func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(RepoViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ContributorInfoView.self, forCellReuseIdentifier: infoCellId)
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoListViewModel?.numberOfRepos ?? 0
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath) as! ContributorInfoView
            cell.repoContributorViewModel = self.repoContributorViewModel
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepoViewCell
            if let viewModel = self.repoListViewModel {
                cell.repoViewModel = RepoViewModel(gitRepo: viewModel.gitHubRepo(for: indexPath.row))
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (self.repoListViewModel?.numberOfRepos ?? 0) > 0 ? (indexPath.row == 0 ? 300 : 150) : 0
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row != 0 {
            if let viewModel = self.repoListViewModel {
                
                let desVC = RepoDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
                desVC.repoViewModel = RepoViewModel(gitRepo: viewModel.gitHubRepo(for: indexPath.row))
                navigationController?.pushViewController(desVC, animated: true)
            }
            
        }
        
        
    }
    
}
