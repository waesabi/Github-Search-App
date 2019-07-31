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
    
    func fetchGitHubRepo(apiUrl: String, completionHandler: @escaping (Result<SearchResult,Error>) -> ()) {
        
        guard let urlString = URL(string: apiUrl) else {
            return
        }
        
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
    
    
}
