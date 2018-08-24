//
//  JSONGitRepository.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/23/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

struct JSONGitRepository: Decodable {

    let id: Int

    let name: String
    
    let stargazers_count: Int
    let forks_count: Int
    
    let description: String?
    
    let owner: JSONGitRepositoryOwner
}
