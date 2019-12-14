//
//  ListController+TableView.swift
//  WatchList
//
//  Created by Ali on 13.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

extension ListController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWatchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellId, for: indexPath) as! ListTableCell
        cell.label.text = myWatchList[indexPath.row].name
        cell.poster.image = UIImage(named: "shazam-poster")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (delete, indexPath) in
            
            let lastAdded = self.myWatchList[indexPath.row]
            
            self.myWatchList.remove(at: indexPath.row)
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
