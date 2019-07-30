//
//  GitHubRepo.swift
//  Github-Search-App
//
//  Created by sanket kumar on 30/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import Foundation

// Make all property as Optional because we donot know if any property becomes unavialable in json response

struct GitHubRepo : Codable {
    let name: String?
    let full_name: String?
    let owner: RepoOwner?
    let description: String?
    let html_url: String?
    let contributors_url: String?
    let watchers: Int?
}

struct RepoOwner : Codable {
    let id: Int?
    let avatar_url: String?
}
