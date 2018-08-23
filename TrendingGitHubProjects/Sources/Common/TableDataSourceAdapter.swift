//
//  TableDataSourceAdapter.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit

class TableDataSourceAdapter<C: UITableViewCell, O>: NSObject, UITableViewDataSource {
    
    let cellIdentifier:String
    let objects: [O]
    let configureCellHandler: (_ cell: C, _ object: O) -> Void
    
    init(identifier cellIdentifier: String, objects: [O], handler configureCellHandler: @escaping (_ cell: C, _ object: O) -> Void) {
        
        self.cellIdentifier = cellIdentifier
        self.objects = objects
        self.configureCellHandler = configureCellHandler
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        (cell as? C).map() {
            let object = self.objects[indexPath.row]
            self.configureCellHandler($0, object)
        }
        
        return cell
    }
}
