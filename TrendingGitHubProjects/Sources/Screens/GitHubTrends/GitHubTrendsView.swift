//
//  GitHubTrendsView.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

protocol GitHubTrendsView: CoordinatorView {
    func blockUI()
    
    func unblockUI()
    
    func show(errorMessage: String)
}
