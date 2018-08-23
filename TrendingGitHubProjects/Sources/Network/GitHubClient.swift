//
//  GitHubClient.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/23/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire

enum GitHubError: Error {
    case httpError(Int)
    case jsonFail(Error)
}

class GitHubClient {

    var webAPIURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

extension GitHubClient {
    
    func createTrendingRepositoriesSignalProducer() -> SignalProducer<[JSONGitRepository], GitHubError> {
        
        let repositoriesURL = self.webAPIURL.appendingPathComponent("search")
            .appendingPathComponent("repositories")
        
        let parameters = ["q": "any", "sort": "stars", "order": "desc"] as [String: Any]
        
        return SignalProducer<[JSONGitRepository], GitHubError> { observer, arg  in
            Alamofire.request(repositoriesURL, method: .get, parameters: parameters).responseData { (response) in
                switch response.result {
                case .success(let jsonData):
                    let decoder = JSONDecoder()
                    do {
                        let repositoriesResult = try decoder.decode(JSONGitRepositoriesResult.self, from: jsonData)
                        observer.send(value: repositoriesResult.items)
                    }
                    catch {
                        observer.send(error: GitHubError.jsonFail(error))
                    }
                case .failure(_):
                    response.response.map {
                        observer.send(error: GitHubError.httpError($0.statusCode))
                    }
                }
            }
        }
    }
}
