//
//  GitHubTrendsCoordinator.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import Swinject

protocol GitHubTrendsCoordinatorInput {
    
    func unblockUI()
    
    func blockUI()
    
    func show(errorMessage: String)
    
    func open(repository repositoryId: Int)
}

class GitHubTrendsCoordinator: GitHubTrendsCoordinatorInput {
    
    static let showGitHubProjectSegue = "showGitHubProjectSegue"

    weak var view: GitHubTrendsView?
    
    private let container: Swinject.Container
    
    init(container: Swinject.Container) {
        self.container = container
    }
    
    func unblockUI() {
        view?.unblockUI()
    }
    
    func blockUI() {
        view?.blockUI()
    }
    
    func show(errorMessage: String) {
        view?.show(errorMessage: errorMessage)
    }
    
    func open(repository repositoryId: Int) {
        let client = container.resolve(GitHubClient.self)!
        let viewModel = GitHubRepositoryViewModel(client: client, repositoryId: repositoryId)
        
        view?.perform(segue: GitHubTrendsCoordinator.showGitHubProjectSegue) { (gitHubProjectViewController: GitHubRepositoryViewController) in
            gitHubProjectViewController.viewModel = viewModel
        }
    }
}
