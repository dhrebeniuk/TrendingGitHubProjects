//
//  CoordinatorView.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import SegueWithCompletion

protocol CoordinatorView: class {
    
    func perform<T>(segue identifier: String, prepare prepareHandler: ((T) -> ())?)
    
    func performWithNavigationController<T>(segue identifier: String, prepare prepareHandler: ((T) -> ())?)
        
}
