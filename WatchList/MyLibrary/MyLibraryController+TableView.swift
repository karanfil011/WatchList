//
//  MyLibraryController+TableView.swift
//  WatchList
//
//  Created by Ali on 13.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

extension MyLibraryController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else {
            return list.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MyLibraryTableCell
            
            let sections = [
                SectionZero(name: "Watch Later", image: UIImage(named: "movie-projector")!),
                SectionZero(name: "Last Added", image: UIImage(named: "romantic-movies")!)
            ]
            
            cell.label.text = sections[indexPath.row].name
            cell.icon.image = sections[indexPath.row].image
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: secondSectionCellId, for: indexPath) as! ListTableCell
            
            cell.label.text = list[indexPath.row].categoryName
            cell.listImage.image = UIImage(named: "movies-folder")
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if indexPath.section == 0 {
            if cell!.isSelected && indexPath.row == 1 {
                let listController = ListController()
                navigationController?.pushViewController(listController, animated: true)
            }
        }
        if indexPath.section == 0 {
            if cell!.isSelected && indexPath.row == 0 {
                let watchLaterController = WatchLaterController()
                navigationController?.pushViewController(watchLaterController, animated: true)
            }
        }
        
        else {
            let sectionOneController = SectionOneListController()
            navigationController?.pushViewController(sectionOneController, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.section == 0 {
            return []
        }
        else {
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                
                let categoryList = self.list[indexPath.row]
                
                self.list.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                let context = CoreDataManager.shared.persistantContainer.viewContext
                context.delete(categoryList)
                
                do {
                    try context.save()
                }
                catch {
                    print("Failed to save", error)
                }
            }
            return [deleteAction]
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        else {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return " "
        }
        else {
            return "My list"
        }

    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0 {
//            return nil
//        }
//        else {
//            let label = UILabel()
//            label.text = "My list"
//            return label
//        }
//    }

    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        else {
            return 50
        }
    }
    
}
