//
//  JSONGitReadme.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

struct JSONGitReadme: Decodable {
    
    let name: String
    let download_url: String
    let content: String
}
