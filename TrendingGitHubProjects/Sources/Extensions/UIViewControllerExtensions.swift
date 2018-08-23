//
//  UIViewControllerExtensions.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func show(errorAlert message: String?) {
        let title = NSLocalizedString("Error", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { (action) in
            //
        }
        alert.addAction(action)
        
        self.present(alert, animated: true) {
            //
        }
    }
}
