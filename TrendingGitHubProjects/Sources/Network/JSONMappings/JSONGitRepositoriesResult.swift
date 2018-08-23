//
//  JSONGitRepositoriesResult.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

struct JSONGitRepositoriesResult: Decodable {
    
    let total_count: Int
    let incomplete_results: Bool
    let items: [JSONGitRepository]
}
