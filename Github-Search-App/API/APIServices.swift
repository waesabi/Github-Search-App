//
//  APIServices.swift
//  Github-Search-App
//
//  Created by sanket kumar on 30/07/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit

/*
 
1 - Search Api - https://api.github.com/search/repositories?q=podcast&sort=watchers&order=desc
2 - Contributer Api - https://api.github.com/repos/esoxjem/MovieGuide/contributors
 
*/

class APIServices {
    
    static let shared = APIServices()
    
    func searchGitRepo(searchedRepo: String, completionHandler: @escaping(Result<SearchResult,Error>) -> ()) {
        
        let urlString = "https://api.github.com/search/repositories?q=\(searchedRepo)&sort=watchers&order=desc"
        
        fetchGenericJSONData(urlString: urlString, completionHandler: completionHandler)
    }
    
    func fetchRepoContributors(urlString: String, completionHandler: @escaping (Result<[RepoContributor], Error>)-> ()) {
        fetchGenericJSONData(urlString: urlString, completionHandler: completionHandler)
    }
    
    func fetchGitHubRepo(apiUrl: String, completionHandler: @escaping (Result<SearchResult,Error>) -> ()) {
        guard let urlString = URL(string: apiUrl) else { return }
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let data = data else {
                return
            }
            do {
                let repos = try JSONDecoder().decode(SearchResult.self, from: data)
            
                completionHandler(.success(repos))
            } catch(let jsonError ) {
                completionHandler(.failure(jsonError))
            }
            
        }.resume()
    }

    
    // Generic Fetch JSON Deta
    
    func fetchGenericJSONData<T : Decodable>(urlString : String, completionHandler : @escaping (Result<T, Error>)->()) {
        
        guard let url = URL(string: urlString) else { return  }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch Social Apps.", error.localizedDescription)
                completionHandler(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(jsonData))
            }
            catch let err {
                print("Failed to decode Json: \(err)")
                completionHandler(.failure(err))
            }
        }.resume()
        
    }
    
    
}
