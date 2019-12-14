//
//  AddListController.swift
//  WatchList
//
//  Created by Ali on 01.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol DataTransferProtocol {
    func selectedList(listName: String)
}

class AddListController: UITableViewController {
    
    let cellId = "cellId"
    
//    var list = [
//        "Watch Later",
//        "Favorite horror movies",
//        "Favorite drama",
//        "Best of 2019",
//        "Favorite 80's movies"
//    ]
    
    var list = [CategoryList]()
    
    var delegate: DataTransferProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        self.list = CoreDataManager.shared.fetchCategoryList()
        
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let categoryList = NSEntityDescription.insertNewObject(forEntityName: "CategoryList", into: context)
        categoryList.setValue("Watch later", forKey: "categoryName")

        do {
            try context.save()
        }
        catch {
            print("Failed to save", error)
        }
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

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
                
                let context = CoreDataManager.shared.persistantContainer.viewContext
                let categoryList = NSEntityDescription.insertNewObject(forEntityName: "CategoryList", into: context)
                categoryList.setValue(summaText, forKey: "categoryName")
                
                do {
                    try context.save()
                }
                catch {
                    print("Error saving", error)
                }
                
                self.list.append(categoryList as! CategoryList)
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
        cell.textLabel?.text = list[indexPath.row].categoryName
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        guard let listName = cell?.textLabel?.text else { return }
        
        dismiss(animated: true) {
            self.delegate?.selectedList(listName: listName)
        }
        
    }
    
}
