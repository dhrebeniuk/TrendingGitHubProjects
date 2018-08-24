//
//  GitHubProjectViewModel.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

class GitHubRepositoryViewModel {
    
    private let client: GitHubClient
    private let projectId: Int
    
    init(client: GitHubClient, projectId: Int) {
        self.client = client
        self.projectId = projectId
    }
}
