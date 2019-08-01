//
//  ContributorListModel.swift
//  Github-Search-App
//
//  Created by sanket kumar on 02/08/2562 BE.
//  Copyright © 2562 sanket kumar. All rights reserved.
//

import Foundation

struct ContributorListModel {
    
    let repoContributorsList : [RepoContributor]
    
    var numberOfContributors : Int {
        return repoContributorsList.count
    }
    
    func repoContributor(for index: Int) -> RepoContributor {
        return repoContributorsList[index]
    }
    
}
