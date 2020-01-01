//
//  DetailViewController.swift
//  WatchList
//
//  Created by Ali on 17.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    
    let moviePosterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "shrek")
        image.layer.cornerRadius = 10
        return image
    }()
    
    let movieTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Shrek"
        title.font = UIFont.boldSystemFont(ofSize: 20)
        return title
    }()
    
    let listLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 12)
        title.text = "List"
        title.textColor = .white
        return title
    }()
    
    let listTextField: UITextField = {
        let title = UITextField()
        title.font = UIFont.boldSystemFont(ofSize: 13)
        title.text = "Watched Movies"
        title.textColor = .white
        title.isUserInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    //    let dateLabel: UILabel = {
    //        let title = UILabel()
    //        title.translatesAutoresizingMaskIntoConstraints = false
    //        title.font = UIFont.boldSystemFont(ofSize: 17)
    //        title.text = "Date"
    //        return title
    //    }()
    
    let dateTextField: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 13)
        title.text = "12.12.2020"
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let myPicLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 25)
        title.textColor = .white
        title.text = "Memories"
        return title
    }()
    
    let myPhoto: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "topPoster")
        image.layer.cornerRadius = 5
        return image
    }()
    
    let detailTextField: UITextView = {
        let title = UITextView()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.text = "Shrek is amazing!"
        title.translatesAutoresizingMaskIntoConstraints = false
        title.showsVerticalScrollIndicator = false
        title.isUserInteractionEnabled = false
        title.backgroundColor = .black
        title.textColor = .white
        return title
    }()
    
    var movie: WatchList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movieDate = movie?.date else { return }
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateformatter.string(from: movieDate)
        
        setupViews()
        view.backgroundColor = .black
        navigationItem.title = movie?.name
        dateTextField.text = dateString
        listTextField.text = movie?.list
    }
    
    private func setupViews() {
        view.addSubview(moviePosterImageView)
        moviePosterImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        moviePosterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        moviePosterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        moviePosterImageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        view.addSubview(dateTextField)
        dateTextField.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 5).isActive = true
        dateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        dateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.addSubview(listTextField)
        listTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor).isActive = true
        listTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor).isActive = true
        listTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        listTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.addSubview(myPicLabel)
        myPicLabel.topAnchor.constraint(equalTo: listTextField.bottomAnchor, constant: 30).isActive = true
        myPicLabel.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor).isActive = true
        myPicLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        myPicLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(myPhoto)
        myPhoto.topAnchor.constraint(equalTo: myPicLabel.bottomAnchor, constant: 10).isActive = true
        myPhoto.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor).isActive = true
        myPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
        myPhoto.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        view.addSubview(detailTextField)
        detailTextField.topAnchor.constraint(equalTo: myPhoto.bottomAnchor, constant: 10).isActive = true
        detailTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor).isActive = true
        detailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        detailTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
}
