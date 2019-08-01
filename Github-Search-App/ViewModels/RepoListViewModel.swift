//
//  RepoListViewModel.swift
//  Github-Search-App
//
//  Created by sanket kumar on 01/08/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import Foundation

struct RepoListViewModel {
    
    var gitHubRepoList : [GitHubRepo]
    
    var numberOfRepos: Int {
        return gitHubRepoList.count
    }
    
    func gitHubRepo(for index: Int) -> GitHubRepo {
        return gitHubRepoList[index]
    }
    
    mutating func sortByName() {
        let sortedRepo = gitHubRepoList.sorted { (repo1, repo2) -> Bool in
            if let wName1 = repo1.name , let wName2 = repo2.name {
                return wName1 < wName2
            }
            return false
        }
        gitHubRepoList = sortedRepo
    }
    
    mutating func sortByWatchersCount() {
        let sortedRepo = gitHubRepoList.sorted { (repo1, repo2) -> Bool in
            if let wCount1 = repo1.watchers , let wCount2 = repo2.watchers {
                return wCount1 > wCount2
            }
            return false
        }
        gitHubRepoList = sortedRepo
    }
    
}

