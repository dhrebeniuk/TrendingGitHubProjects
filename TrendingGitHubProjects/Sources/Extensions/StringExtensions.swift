//
//  StringExtensions.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

extension String {
    
    var strippedHTML: String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            .trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
}
