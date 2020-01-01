//
//  MyLibraryController.swift
//  WatchList
//
//  Created by Ali on 13.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct SectionZero {
    var name: String
    var image: UIImage
}

class MyLibraryController: UITableViewController, SendListNameToLibraryDelegate {
    func sendListName() {
        
        self.list = CoreDataManager.shared.fetchCategoryList()
        tableView.reloadData()
    }
    
    var listController: AddListController?
    
    let cellId = "cellId"
    let secondSectionCellId = "secondSectionCellId"
    
    var list = [CategoryList]()
    var watchList = [WatchList]()
    let context = CoreDataManager.shared.persistantContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.tableFooterView = UIView()
        tableView.register(MyLibraryTableCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ListTableCell.self, forCellReuseIdentifier: secondSectionCellId)
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        view.backgroundColor = .white
        navigationItem.title = "My Library"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd))
        
        self.list = CoreDataManager.shared.fetchCategoryList()
        tableView.reloadData()
    }
    
    @objc private func handleAdd() {
        let addViewController = AddMovieController()
        let navController = UINavigationController(rootViewController: addViewController)
        present(navController, animated: true, completion: nil)
        addViewController.toMainDelegate = self
    }
}
