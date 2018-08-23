//
//  GitHubTrendsViewModel.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/23/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import ReactiveSwift

class GitHubTrendsViewModel {

    private let gitHubClient: GitHubClient

    init(client: GitHubClient) {
        gitHubClient = client
    }
    
    private(set) var repositories = MutableProperty<[JSONGitRepository]>([])

    func loadRepositories() {
        gitHubClient.createTrendingRepositoriesSignalProducer().start { [weak self] in
            switch $0 {
            case .value(let resitories):
                self?.repositories.value = resitories
            case .failed(_):
                break
            default:
                break
            }
        }
    }
    
}

