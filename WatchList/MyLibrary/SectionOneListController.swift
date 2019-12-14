//
//  SectionOneListController.swift
//  WatchList
//
//  Created by Ali on 14.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

class SectionOneListController: UITableViewController {
    
    let sectionOneCellId = "sectionOneCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ListTableCell.self, forCellReuseIdentifier: sectionOneCellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionOneCellId, for: indexPath) as! ListTableCell
        
        cell.label.text = "Golden"
        
        return cell
    }
    
}
