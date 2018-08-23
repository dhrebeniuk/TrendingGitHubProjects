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
    
    private var dataSourceAdapter: TableDataSourceAdapter<UITableViewCell, JSONGitRepository>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.repositories.producer
            .startWithValues() { [weak self] repositories in
                self?.refreshControl?.attributedTitle = nil
                
                let dataSourceAdapter = TableDataSourceAdapter<UITableViewCell, JSONGitRepository>(identifier: GitHubTrendsViewController.projectCellIdentifier, objects: repositories) { (cell, repository) in
                    cell.textLabel?.text = repository.name
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
