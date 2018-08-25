//
//  Assembly.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Swinject

protocol Assembly {
    func assemble(in container:  Swinject.Container)
}
