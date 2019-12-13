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
    
    let list = ["Movies", "TV Shows", "My Top 10", "Favorite Horror Movies"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MyLibraryTableCell.self, forCellReuseIdentifier: cellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: secondSectionCellId)
        
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
