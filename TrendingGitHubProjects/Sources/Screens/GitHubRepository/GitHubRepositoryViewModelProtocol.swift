//
//  GitHubRepositoryViewModelProtocol.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/25/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import ReactiveSwift
import Kingfisher
import Result

protocol GitHubRepositoryViewModelProtocol {
    var projectTitle: Signal<String, NoError> { get }
    var userName: Signal<String, NoError> { get }
    var repositoryDescription: Signal<String, NoError> { get }
    var ownerAvatarResource: Signal<Resource?, NoError> { get }
    var starsCountString: Signal<String, NoError> { get }
    var forksCountString: Signal<String, NoError> { get }
    var readMeName: Signal<String, NoError> { get }
    var readMeContent: Signal<String?, NoError> { get }
    
    func loadRepository()
}
