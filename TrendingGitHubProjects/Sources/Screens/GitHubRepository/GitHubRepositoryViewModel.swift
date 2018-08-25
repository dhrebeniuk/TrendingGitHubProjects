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
import Result

class GitHubRepositoryViewModel: GitHubRepositoryViewModelProtocol {
    
    private let client: GitHubClient
    private let repositoryId: Int
    
    init(client: GitHubClient, repositoryId: Int) {
        self.client = client
        self.repositoryId = repositoryId
    }
    
    private var projectTitlePipe = Signal<String, NoError>.pipe()
    var projectTitle: Signal<String, NoError> {
        return projectTitlePipe.output
    }
    
    private var userNamePipe = Signal<String, NoError>.pipe()
    var userName: Signal<String, NoError> {
        return userNamePipe.output
    }
    
    private var repositoryDescriptionPipe = Signal<String, NoError>.pipe()
    var repositoryDescription: Signal<String, NoError> {
        return repositoryDescriptionPipe.output
    }
    
    private var ownerAvatarResourcePipe = Signal<Resource?, NoError>.pipe()
    var ownerAvatarResource: Signal<Resource?, NoError> {
        return ownerAvatarResourcePipe.output
    }
    
    private var starsCountStringPipe = Signal<String, NoError>.pipe()
    var starsCountString: Signal<String, NoError> {
        return starsCountStringPipe.output
    }
    
    private var forksCountStringPipe = Signal<String, NoError>.pipe()
    var forksCountString: Signal<String, NoError> {
        return forksCountStringPipe.output
    }
    
    private var readMeNamePipe = Signal<String, NoError>.pipe()
    var readMeName: Signal<String, NoError> {
        return readMeNamePipe.output
    }
    
    private var readMeContentPipe = Signal<String?, NoError>.pipe()
    var readMeContent: Signal<String?, NoError> {
        return readMeContentPipe.output
    }

    func loadRepository() {
        client.createRepositoryDetailsSignalProducer(repositoryId: repositoryId)
            .observe(on: QueueScheduler.main)
            .start { [weak self] in
                switch $0 {
                case .value(let repository):
                    self?.projectTitlePipe.input.send(value: repository.name)
                    self?.userNamePipe.input.send(value: repository.owner.login)
                    self?.repositoryDescriptionPipe.input.send(value: repository.description ?? "")
                    
                    self?.ownerAvatarResourcePipe.input.send(value: repository.owner.avatar_url.flatMap { urlString -> Resource? in
                        URL(string: urlString)
                    })
                    
                    self?.starsCountStringPipe.input.send(value: String(format: NSLocalizedString("%@ Stars", comment: ""), "\(repository.stargazers_count)"))
                    
                    self?.forksCountStringPipe.input.send(value: String(format: NSLocalizedString("%@ Forks", comment: ""), "\(repository.forks_count)"))
                    
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
                    self?.readMeNamePipe.input.send(value: readMe.name)
                    self?.readMeContentPipe.input.send(value: Data(base64Encoded: readMe.content, options: .ignoreUnknownCharacters)
                        .flatMap { String(data: $0, encoding: .utf8) }
                        .flatMap { $0.strippedHTML })
                case .failed(_):
                    break
                default:
                    break
                }
        }
        
    }
}
