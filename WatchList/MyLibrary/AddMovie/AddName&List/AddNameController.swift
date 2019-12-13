//
//  AddNameController.swift
//  Watched
//
//  Created by Ali on 02.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

struct TopRatedMovies: Decodable {
    let page: Int
    let results: [JSonMovie]?
}

struct JSonMovie: Decodable {
    let id: Int?
    let title: String?
}

protocol SendNameBack {
    func sendSelectedTitle(name: String)
}

class AddNameController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let cellId = "cellId"
    
    let moviesList = [
        "spider-man",
        "the hulk",
        "iron man"
    ]
    
    var filteredArray = [String]()
    var isSearching = false
    
    let addNameTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let searchBar: UISearchBar = {
        let sBar = UISearchBar()
        sBar.translatesAutoresizingMaskIntoConstraints = false
        return sBar
    }()
    
    var jsonMoviesTitleArray = [String]()
    
    var delegate: SendNameBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addNameTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        getJSONData()
        
        
        
        navigationItem.title = "Add one"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
    }
    
    private func getJSONData() {
        
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=af86bc337bd12d1276a8e815b9c45557&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if let response = response {
                print(response)
            }
            
            do {
                let movie = try JSONDecoder().decode(TopRatedMovies.self, from: data)
                //                self.jsonMoviesTitleArray.append(movie)
                
                for i in movie.results! {
                    self.jsonMoviesTitleArray.append(i.title!)
                    DispatchQueue.main.async {
                        self.addNameTableView.reloadData()
                    }
                }
                
            } catch {
                print("Catched error here", error)
            }
            
            }.resume()
        
    }
    
    @objc private func handleAdd() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredArray.count
        }
        else {
            return jsonMoviesTitleArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var movie: String?
        
        if isSearching {
            movie = filteredArray[indexPath.row]
        }
        else {
            movie = jsonMoviesTitleArray[indexPath.row]
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = movie
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.isSelected {
            
            guard let name = cell.textLabel?.text else { return }
            
            dismiss(animated: true) {
                self.delegate?.sendSelectedTitle(name: name)
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            addNameTableView.reloadData()
        }
        else {
            isSearching = true
            filteredArray = jsonMoviesTitleArray.filter({$0.range(of: searchBar.text!, options: .caseInsensitive) != nil})
            addNameTableView.reloadData()
        }
    }
    
    private func setupView() {
        
        addNameTableView.delegate = self
        addNameTableView.dataSource = self
        
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(addNameTableView)
        addNameTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        addNameTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addNameTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addNameTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
