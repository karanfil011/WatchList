//
//  MyLibraryController.swift
//  WatchList
//
//  Created by Ali on 13.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

struct SectionZero {
    var name: String
    var image: UIImage
}

class MyLibraryController: UITableViewController {
    
    let cellId = "cellId"
    let secondSectionCellId = "secondSectionCellId"
    
    var list = [CategoryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.list = CoreDataManager.shared.fetchCategoryList()
        tableView.reloadData()
        
        tableView.tableFooterView = UIView()
        tableView.register(MyLibraryTableCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ListTableCell.self, forCellReuseIdentifier: secondSectionCellId)
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        view.backgroundColor = .white
        navigationItem.title = "My Library"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd))
    }
    
    @objc private func handleAdd() {
        let addViewController = AddMovieController()
        let navController = UINavigationController(rootViewController: addViewController)
        present(navController, animated: true, completion: nil)
    }
}
