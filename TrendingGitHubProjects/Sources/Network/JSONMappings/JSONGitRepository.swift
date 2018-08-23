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
    let node_id: String
    let name: String
    let full_name: String
    let description: String?
    
    let owner: JSONGitRepositoryOwner
}
