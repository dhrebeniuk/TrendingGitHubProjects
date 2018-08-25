//
//  GitHubTrendsViewModelProtocol.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/25/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol GitHubTrendsViewModelProtocol {
    var repositories: Signal<[JSONGitRepository], NoError> { get }
    
    func loadRepositories(query: String?)
    
    func open(repository: JSONGitRepository)
}
