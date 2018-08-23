//
//  GitHubTrendsCoordinator.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

protocol GitHubTrendsCoordinatorInput {
    
    func unblockUI()
    
    func blockUI()
    
    func show(errorMessage: String)
    
}

class GitHubTrendsCoordinator: GitHubTrendsCoordinatorInput {
    
    weak var view: GitHubTrendsView?
    
    func unblockUI() {
        view?.unblockUI()
    }
    
    func blockUI() {
        view?.blockUI()
    }
    
    func show(errorMessage: String) {
        view?.show(errorMessage: errorMessage)
    }
}
