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
        
        bindViewModel()
        
        viewModel.loadRepository()
    }
    
    private func bindViewModel() {
        navigationItem.reactive.title <~ viewModel.projectTitle
        avatarImageView?.reactive.resource <~ viewModel.ownerAvatarResource

        userNameLabel?.reactive.isHidden <~ viewModel.userName.map() { $0.count == 0 }
        userNameLabel?.reactive.text <~ viewModel.userName
        
        descriptionTitle?.reactive.isHidden <~ viewModel.repositoryDescription.map() { $0.count == 0 }
        descriptionTitle?.reactive.text <~ viewModel.repositoryDescription
        
        starsLabel?.reactive.isHidden <~ viewModel.starsCountString.map() { $0.count == 0 }
        starsLabel?.reactive.text <~ viewModel.starsCountString
        
        forksLabel?.reactive.isHidden <~ viewModel.forksCountString.map() { $0.count == 0 }
        forksLabel?.reactive.text <~ viewModel.forksCountString
        
        readMeNameLabel?.reactive.isHidden <~ viewModel.readMeName.map() { $0.count == 0 }
        readMeNameLabel?.reactive.text <~ viewModel.readMeName
        
        readMeContentLabel?.reactive.isHidden <~ viewModel.readMeContent.map() { $0?.count == 0 }
        readMeContentLabel?.reactive.text <~ viewModel.readMeContent
    }

}
