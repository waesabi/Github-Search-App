//
//  ContributorViewModel.swift
//  Github-Search-App
//
//  Created by sanket kumar on 02/08/2562 BE.
//  Copyright © 2562 sanket kumar. All rights reserved.
//

import Foundation


struct ContributorViewModel {
    
    let repoContributor: RepoContributor
    
    var login: String {
        return repoContributor.login ?? ""
    }
    
    var avatarUrl : URL? {
        if let urlString = repoContributor.avatar_url {
            return URL(string: urlString)
        }
        return URL(string: "")
    }
    
    var reposUrl: String {
        return repoContributor.repos_url ?? ""
    }
}
