//
//  RepoViewModel.swift
//  Github-Search-App
//
//  Created by sanket kumar on 01/08/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import Foundation

struct RepoViewModel {
    
    let gitRepo : GitHubRepo
    
    var name : String {
        return gitRepo.name ?? ""
    }
    
    var fullName: String {
        return gitRepo.full_name ?? ""
    }
    
    var description: String {
        return gitRepo.description ?? ""
    }
    var htmlUrl : String {
        return gitRepo.html_url ?? ""
    }
    
    var contributorsUrl: String {
        return gitRepo.contributors_url ?? ""
    }
    
    var watchers: String {
        return "\(gitRepo.watchers ?? 0) Watcher"
    }
    
    var avatarUrl : URL? {
        if let owner = gitRepo.owner, let urlString = owner.avatar_url {
            return URL(string: urlString)
        }
        return URL(string: "")
    }
    
    
    
}
