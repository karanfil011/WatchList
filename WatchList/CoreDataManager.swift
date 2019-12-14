//
//  CoreDataManager.swift
//  WatchList
//
//  Created by Ali on 13.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WatchListModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                print("Loading store failed", error)
            }
        })
        return container
    }()
    
    func fetchWatchList() -> [WatchList] {
        let context = persistantContainer.viewContext
        let fetchRequest = NSFetchRequest<WatchList>(entityName: "WatchList")
        
        do {
            let watchList = try context.fetch(fetchRequest)
            return watchList
        }
        catch {
            print("Failed to catch", error)
            return []
        }
        
    }
    
    func fetchCategoryList() -> [CategoryList] {
        let context = persistantContainer.viewContext
        let fetchRequest = NSFetchRequest<CategoryList>(entityName: "CategoryList")
        
        do {
            let categoryList = try context.fetch(fetchRequest)
            return categoryList
        }
        catch {
            print("Failed to catch", error)
            return []
        }
    }
    
}
