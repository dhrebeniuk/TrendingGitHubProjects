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

    private let client: GitHubClient
    private let coordinator: GitHubTrendsCoordinatorInput
    
    init(client: GitHubClient, coordinator: GitHubTrendsCoordinatorInput) {
        self.client = client
        self.coordinator = coordinator
    }
    
    private(set) var repositories = MutableProperty<[JSONGitRepository]>([])

    func loadRepositories() {
        coordinator.blockUI()
        
        client.createTrendingRepositoriesSignalProducer()
            .observe(on: QueueScheduler.main)
            .start { [weak self] in
                self?.coordinator.unblockUI()
                switch $0 {
                case .value(let resitories):
                    self?.repositories.value = resitories
                case .failed(let error):
                    self?.coordinator.show(errorMessage: error.localizedDescription)
                default:
                    break
                }
        }
    }
    
}

