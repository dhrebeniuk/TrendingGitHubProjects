//
//  ApplicationAssemble.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class ApplicationAssemble {
    
    let container = Container()

    func setup() {
        Container.loggingFunction = nil
        
        container.register(GitHubClient.self) { resolver in
            return GitHubClient()
        }
        
        self.registerAssemblies(in: self.container)
    }
    
    private func registerAssemblies(in container: Swinject.Container) {
        let gitHubTrendsAssemble = GitHubTrendsAssemble()
        gitHubTrendsAssemble.assembly(in: container)
    }
    
}
