//
//  GitHubTrendsAssemble.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class GitHubTrendsAssembly: Assembly {

    func assemble(in container:  Swinject.Container) {
        
        container.register(GitHubTrendsViewModelProtocol.self) { resolver in
            let client = resolver.resolve(GitHubClient.self)!
            let coordinator = resolver.resolve(GitHubTrendsCoordinator.self)!
            let viewModel = GitHubTrendsViewModel(client: client, coordinator: coordinator)
            return viewModel
        }
    
        container.register(GitHubTrendsCoordinator.self) { resolver in
            return GitHubTrendsCoordinator(container: container)
        }.inObjectScope(.container)
        
        container.storyboardInitCompleted(GitHubTrendsViewController.self) { resolver, controller in
            let coordinator = resolver.resolve(GitHubTrendsCoordinator.self)!
            coordinator.view = controller

            let viewModel = resolver.resolve(GitHubTrendsViewModelProtocol.self)!
            controller.viewModel = viewModel
        }
        
    }
    
}
