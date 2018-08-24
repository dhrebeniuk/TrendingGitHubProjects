//
//  GitHubProjectViewModel.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import ReactiveSwift
import Kingfisher

class GitHubRepositoryViewModel {
    
    private let client: GitHubClient
    private let repositoryId: Int
    
    init(client: GitHubClient, repositoryId: Int) {
        self.client = client
        self.repositoryId = repositoryId
    }
    
    private(set) var projectTitle = MutableProperty<String>("")
    private(set) var userName = MutableProperty<String>("")
    private(set) var repositoryDescription = MutableProperty<String>("")
    private(set) var ownerAvatarResource = MutableProperty<Resource?>(nil)

    private(set) var starsCountString = MutableProperty<String?>("")
    private(set) var forksCountString = MutableProperty<String?>("")
    
    private(set) var readMeName = MutableProperty<String>("")
    private(set) var readMeContent = MutableProperty<String?>(nil)

    func loadRepository() {
        client.createRepositoryDetailsSignalProducer(repositoryId: repositoryId)
            .observe(on: QueueScheduler.main)
            .start { [weak self] in
                switch $0 {
                case .value(let repository):
                    self?.projectTitle.value = repository.name
                    self?.userName.value = repository.owner.login
                    self?.repositoryDescription.value = repository.description ?? ""
                    self?.ownerAvatarResource.value = repository.owner.avatar_url.flatMap { urlString -> Resource? in
                        URL(string: urlString)
                    }
                    
                    self?.starsCountString.value = String(format: NSLocalizedString("%@ Stars", comment: ""), "\(repository.stargazers_count)")
                    
                    self?.forksCountString.value = String(format: NSLocalizedString("%@ Forks", comment: ""), "\(repository.forks_count)")
                    
                    self?.loadReadMe(ownerName: repository.owner.login, repositoryName: repository.name)
                case .failed(_):
                    break
                default:
                    break
                }
        }
    }
    
    private func loadReadMe(ownerName: String, repositoryName: String) {
        client.createReadMeSignalProducer(ownerName: ownerName, repositoryName: repositoryName)
            .observe(on: QueueScheduler.main)
            .start { [weak self] in
                switch $0 {
                case .value(let readMe):
                    self?.readMeName.value = readMe.name
                    self?.readMeContent.value = Data(base64Encoded: readMe.content, options: .ignoreUnknownCharacters)
                        .flatMap { String(data: $0, encoding: .utf8) }
                        .flatMap { $0.strippedHTML }
                case .failed(_):
                    break
                default:
                    break
                }
        }
        
    }
}
