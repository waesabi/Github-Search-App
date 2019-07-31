//
//  RepoDetailViewController.swift
//  Github-Search-App
//
//  Created by sanket kumar on 31/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

class RepoDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var gitRepo : GitHubRepo?
    let repoDetailId = "repoDetailId"
    let repoContributorId = "repoContributorId"
    var repoContributors = [RepoContributor]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        fetchContributorDetails()
    }

    fileprivate func setupNavigationBar() {
        if let repo = gitRepo, let name = repo.name {
            navigationItem.title = name
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(RepoDetailViewCell.self, forCellWithReuseIdentifier: repoDetailId)
        collectionView.register(RepoContributorViewCell.self, forCellWithReuseIdentifier: repoContributorId)
        
    }
    
    fileprivate func fetchContributorDetails() {
        if let gitRepo = self.gitRepo, let urlString = gitRepo.contributors_url {
            APIServices.shared.fetchRepoContributors(urlString: urlString) { (result) in
                switch result {
                case .success(let result):
                    self.repoContributors = result
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                default:
                    return
                }
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: repoDetailId, for: indexPath) as! RepoDetailViewCell
            cell.gitRepo = self.gitRepo
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: repoContributorId, for: indexPath) as! RepoContributorViewCell
            cell.contributorController.repoContributors = self.repoContributors
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size : CGSize = indexPath.row == 0 ? CGSize(width: view.frame.width, height: 450) : CGSize(width: view.frame.width, height: 200)
        
        return size
    }
    
}
