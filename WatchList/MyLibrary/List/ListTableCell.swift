//
//  ListTableCell.swift
//  WatchList
//
//  Created by Ali on 13.12.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit

class ListTableCell: UITableViewCell {
    
    let poster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let listImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font  = UIFont.boldSystemFont(ofSize: 20)
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(poster)
        poster.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        poster.heightAnchor.constraint(equalToConstant: 65).isActive = true
        poster.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        addSubview(listImage)
        listImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        listImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        listImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        listImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        label.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
                
    }
    
}
