//
//  ListController.swift
//  WatchList
//
//  Created by Ali on 13.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

class ListController: UITableViewController, AddToListDelegate {
    func didAddToList(watchList: WatchList, listName: String) {
        myWatchList.append(watchList)
        tableView.reloadData()
    }
    
    var myWatchList = [WatchList]()
    
    let listCellId = "listCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ListTableCell.self, forCellReuseIdentifier: listCellId)
        navigationItem.title = "Last Added"
        
        self.myWatchList = CoreDataManager.shared.fetchWatchList()
        tableView.reloadData()
    }
    
    
    
}
