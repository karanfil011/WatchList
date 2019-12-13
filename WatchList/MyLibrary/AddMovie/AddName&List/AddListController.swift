//
//  AddListController.swift
//  WatchList
//
//  Created by Ali on 01.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

protocol DataTransferProtocol {
    func selectedList(listName: String)
}

class AddListController: UITableViewController {
    
    let cellId = "cellId"
    
    var list = [
        "Watch Later",
        "Favorite horror movies",
        "Favorite drama",
        "Best of 2019",
        "Favorite 80's movies"
    ]
    
    var delegate: DataTransferProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.title = "List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add list", style: .plain, target: self, action: #selector(handleAddList))
        
    }
    
    @objc private func handleAddList() {
        
        let alert = UIAlertController(title: "Add List", message: "Adding some list", preferredStyle: .alert)
        alert.addTextField { (text) in
            text.placeholder = "Write here my boy"
        }
        let action = UIAlertAction(title: "Save", style: .default) { (action) in
            if let summaText = alert.textFields?.first?.text {
                self.list.append(summaText)
                let indexPath = IndexPath(row: self.list.count - 1, section: 0)
                
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        guard let listName = cell?.textLabel?.text else { return }
        
        dismiss(animated: true) {
            self.delegate?.selectedList(listName: listName)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                        
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        return [deleteAction]
    }
    
}
