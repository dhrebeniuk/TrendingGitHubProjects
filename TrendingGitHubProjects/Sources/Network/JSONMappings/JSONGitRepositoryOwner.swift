//
//  JSONGitRepositoryOwner.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/23/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

struct JSONGitRepositoryOwner: Decodable {
    let login: String
    let avatar_url: String?
}
