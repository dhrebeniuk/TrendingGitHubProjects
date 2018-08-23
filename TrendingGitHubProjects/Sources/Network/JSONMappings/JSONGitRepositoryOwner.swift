//
//  JSONGitRepositoryOwner.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/23/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

struct JSONGitRepositoryOwner: Decodable {
    let id: Int
    let login: String
    let node_id: String
    let avatar_url: String
    let html_url: String
    let type: String
}
