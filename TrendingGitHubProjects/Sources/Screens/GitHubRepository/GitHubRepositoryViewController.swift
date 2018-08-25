//
//  GitHubProjectViewController.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Kingfisher

class GitHubRepositoryViewController: UIViewController {

    var viewModel: GitHubRepositoryViewModelProtocol!
    
    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var descriptionTitle: UILabel?
    @IBOutlet weak var starsLabel: UILabel?
    @IBOutlet weak var forksLabel: UILabel?
    @IBOutlet weak var readMeNameLabel: UILabel?
    @IBOutlet weak var readMeContentLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.reactive.title <~ viewModel.projectTitle
        userNameLabel?.reactive.text <~ viewModel.userName
        descriptionTitle?.reactive.text <~ viewModel.repositoryDescription
        avatarImageView?.reactive.resource <~ viewModel.ownerAvatarResource
        starsLabel?.reactive.text <~ viewModel.starsCountString
        forksLabel?.reactive.text <~ viewModel.forksCountString
        
        readMeNameLabel?.reactive.text <~ viewModel.readMeName
        readMeContentLabel?.reactive.text <~ viewModel.readMeContent
        
        viewModel.loadRepository()
    }

}
