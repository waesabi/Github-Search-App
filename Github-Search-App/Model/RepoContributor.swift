//
//  RepoContributor.swift
//  Github-Search-App
//
//  Created by sanket kumar on 31/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import Foundation

struct RepoContributor: Decodable {
    let login: String?
    let avatar_url: String?
    let repos_url: String?
}
