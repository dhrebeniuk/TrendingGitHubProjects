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

class GitHubTrendsAssemble: Assemble {

    func assembly(in container:  Swinject.Container) {
        
        container.register(GitHubTrendsViewModel.self) { resolver in
            let client = resolver.resolve(GitHubClient.self)!
            let viewModel = GitHubTrendsViewModel(client: client)
            return viewModel
        }
        
        container.storyboardInitCompleted(GitHubTrendsViewController.self) { resolver, controller in
            let viewModel = resolver.resolve(GitHubTrendsViewModel.self)!
            controller.viewModel = viewModel
        }
        
    }
    
}
