//
//  Assemble.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Swinject

protocol Assemble {
    func assembly(in container:  Swinject.Container)
}
