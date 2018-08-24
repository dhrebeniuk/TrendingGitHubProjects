//
//  GitHubProjectViewModel.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import ReactiveSwift

class GitHubRepositoryViewModel {
    
    private let client: GitHubClient
    private let repositoryId: Int
    
    init(client: GitHubClient, repositoryId: Int) {
        self.client = client
        self.repositoryId = repositoryId
    }
    
    private(set) var projectTitle = MutableProperty<String>("")
    private(set) var userName = MutableProperty<String>("")
    private(set) var repositoryDescription = MutableProperty<String>("")

    func loadRepository() {
        client.createRepositoryDetailsSignalProducer(repositoryId: repositoryId)
            .observe(on: QueueScheduler.main)
            .start { [weak self] in
                switch $0 {
                case .value(let repository):
                    self?.projectTitle.value = repository.name
                    self?.userName.value = repository.owner.login
                    self?.repositoryDescription.value = repository.description ?? ""
                case .failed(_):
                    break
                default:
                    break
                }
        }
    }
}
