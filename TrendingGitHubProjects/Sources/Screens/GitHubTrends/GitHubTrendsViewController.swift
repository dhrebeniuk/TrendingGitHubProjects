//
//  GitHubTrendsViewController.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/21/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class GitHubTrendsViewController: UITableViewController {

    var viewModel: GitHubTrendsViewModel!
    
    private static let projectCellIdentifier = "projectCellIdentifier"
    
    private var dataSourceAdapter: TableDataSourceAdapter<GitHubTrendsCell, JSONGitRepository>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        viewModel.repositories.producer
            .startWithValues() { [weak self] repositories in
                self?.refreshControl?.attributedTitle = nil
                
                let dataSourceAdapter = TableDataSourceAdapter<GitHubTrendsCell, JSONGitRepository>(identifier: GitHubTrendsViewController.projectCellIdentifier, objects: repositories) { (cell, repository) in
                    
                    cell.projectNameLabel?.text = repository.full_name
                    cell.projectStarsCountLabel?.text = "\(repository.forks_count)"
                    cell.projectDescriptionLabel?.text = repository.description ?? ""
                }
                self?.dataSourceAdapter = dataSourceAdapter
                self?.tableView.dataSource = dataSourceAdapter
                self?.tableView.reloadData()
        }
        
        viewModel.loadRepositories()
    }
    
    @IBAction func refreshData(_ sender: Any) {
        viewModel.loadRepositories()
    }
}

extension GitHubTrendsViewController: GitHubTrendsView {
    
    func blockUI() {
        refreshControl?.beginRefreshing()
    }
    
    func unblockUI() {
        refreshControl?.endRefreshing()
    }
    
    func show(errorMessage: String) {
        refreshControl?.attributedTitle = NSAttributedString(string: NSLocalizedString("Error", comment: ""))
        
        show(errorAlert: errorMessage)
    }
    
}
