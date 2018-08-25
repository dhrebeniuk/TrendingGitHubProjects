//
//  GitHubTrendsViewModel.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/23/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class GitHubTrendsViewModel: GitHubTrendsViewModelProtocol {

    private let client: GitHubClient
    private let coordinator: GitHubTrendsCoordinatorProtocol
    
    private var repositoriesPipe = Signal<[JSONGitRepository], NoError>.pipe()
    var repositories: Signal<[JSONGitRepository], NoError> {
        return repositoriesPipe.output
    }

    init(client: GitHubClient, coordinator: GitHubTrendsCoordinatorProtocol) {
        self.client = client
        self.coordinator = coordinator
    }
    
    func loadRepositories(query: String? = nil) {
        coordinator.blockUI()
        
        let seachQuery = (query?.count ?? 0) > 0 ? query ?? "" : "any"
        
        client.createTrendingRepositoriesSignalProducer(query: seachQuery)
            .observe(on: QueueScheduler.main)
            .start { [weak self] in
                self?.coordinator.unblockUI()
                switch $0 {
                case .value(let resitories):
                    self?.repositoriesPipe.input.send(value: resitories)
                case .failed(let error):
                    switch error {
                    case .apiError(let errorMessage):
                        self?.coordinator.show(errorMessage: errorMessage)
                    case .fail(let error):
                        self?.coordinator.show(errorMessage: error.localizedDescription)
                    }
                default:
                    break
                }
        }
    }
    
    func open(repository: JSONGitRepository) {
       coordinator.open(repository: repository.id)
    }
}

