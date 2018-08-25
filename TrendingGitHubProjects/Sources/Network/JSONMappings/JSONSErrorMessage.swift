//
//  JSONSErrorMessage.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/25/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

struct JSONErrorMessage: Decodable {
    let message: String
    let documentation_url: String?
}
