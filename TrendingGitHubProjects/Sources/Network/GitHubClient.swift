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
    
    func createTrendingRepositoriesSignalProducer(query: String = "any") -> SignalProducer<[JSONGitRepository], GitHubError> {
        
        let repositoriesURL = self.webAPIURL.appendingPathComponent("search")
            .appendingPathComponent("repositories")
        
        let parameters = ["q": query, "sort": "stars", "order": "desc"] as [String: Any]
        
        return SignalProducer<[JSONGitRepository], GitHubError> { observer, arg  in
            Alamofire.request(repositoriesURL, method: .get, parameters: parameters).responseData { response in
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
    
    func createRepositoryDetailsSignalProducer(repositoryId: Int) -> SignalProducer<JSONGitRepository, GitHubError> {
        
        let repositoryURL = self.webAPIURL
            .appendingPathComponent("repositories").appendingPathComponent("\(repositoryId)")
        
        return SignalProducer<JSONGitRepository, GitHubError> { observer, arg  in
            Alamofire.request(repositoryURL, method: .get, parameters: [:]).responseData { response in
                switch response.result {
                case .success(let jsonData):
                    let decoder = JSONDecoder()
                    do {
                        let repository = try decoder.decode(JSONGitRepository.self, from: jsonData)
                        observer.send(value: repository)
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
    
    func createReadMeSignalProducer(ownerName: String, repositoryName: String) -> SignalProducer<JSONGitReadme, GitHubError> {
        let readmeURL = self.webAPIURL
            .appendingPathComponent("repos")
            .appendingPathComponent(ownerName)
            .appendingPathComponent(repositoryName)
            .appendingPathComponent("readme")
        
        return SignalProducer<JSONGitReadme, GitHubError> { observer, arg  in
            
            
            
            Alamofire.request(readmeURL, method: .get, parameters: [:], headers: ["X-GitHub-Media-Type": "application/vnd.github.VERSION.html"]).responseData { response in
                switch response.result {
                case .success(let jsonData):
                    let decoder = JSONDecoder()
                    do {
                        let readMe = try decoder.decode(JSONGitReadme.self, from: jsonData)
                        observer.send(value: readMe)
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
