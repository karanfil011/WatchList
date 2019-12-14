//
//  WatchLaterController.swift
//  WatchList
//
//  Created by Ali on 13.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

class WatchLaterController: UITableViewController {
    
    let wlCellId = "wlCellId"
    
    var watchList = [WatchList]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        self.watchList = CoreDataManager.shared.fetchWatchList()
        tableView.register(ListTableCell.self, forCellReuseIdentifier: wlCellId)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let watchLaterWL = watchList.filter({$0.list == "Watch Later"})
        return watchLaterWL.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: wlCellId, for: indexPath) as! ListTableCell
        
        let watchLaterWL = watchList.filter({$0.list == "Watch Later"})
        
        if watchLaterWL[indexPath.row].list == "Watch Later" {
            cell.label.text = watchLaterWL[indexPath.row].name
            cell.poster.image = UIImage(named: "shazam-poster")
            return cell
        }
        else {
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (delete, indexPath) in
            
            let watchLaterWL = self.watchList.filter({$0.list == "Watch Later"})
            
            let lastAdded = watchLaterWL[indexPath.row]
            
            self.watchList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistantContainer.viewContext
            context.delete(lastAdded)
            
            do {
                try context.save()
            }
            catch {
                print(error)
            }
            
        }
        return [deleteAction]
    }
}
