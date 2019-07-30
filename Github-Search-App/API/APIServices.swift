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
2 -
 
*/

class APIServices {
    
    static let shared = APIServices()
    
    func fetchGitHubRepo(apiUrl: String, completionHandler: @escaping (Result<SearchResult,Error>) -> ()) {
        print("fetchGitHubRepo Called")
        
        guard let urlString = URL(string: apiUrl) else {
            print("Url String null")
            return
        }
        
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            print("fetching api")
            if let error = error {
                print("Error is occured")
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                print("Data is null")
                return
            }
            
            do {
                print("got the result")
                let repos = try JSONDecoder().decode(SearchResult.self, from: data)
                repos.items.forEach({ (r) in
                    print(r.full_name)
                })
                completionHandler(.success(repos))
            } catch(let jsonError ) {
                completionHandler(.failure(jsonError))
            }
            
        }.resume()
        print("End")
    }
    
}
