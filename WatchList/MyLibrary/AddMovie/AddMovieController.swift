//
//  AddMovieController.swift
//  Watched
//
//  Created by Ali on 26.11.2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//protocol AddToListDelegate {
//    func didAddToList(watched: Watched, listName: String)
//}

class AddMovieController: UIViewController, DataTransferProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SendNameBack {
    func sendSelectedTitle(name: String) {
        titleTextField.text = name
    }
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.text = "Name"
        return title
    }()
    
    let titleTextField: UITextField = {
        let title = UITextField()
        title.font = UIFont.boldSystemFont(ofSize: 25)
        title.placeholder = "Shrek"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let addMovieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 7
        return button
    }()
    
    let listLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.text = "List"
        return title
    }()
    
    let listTextField: UITextField = {
        let title = UITextField()
        title.font = UIFont.boldSystemFont(ofSize: 25)
        title.placeholder = "Movies"
        title.isUserInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let addListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 7
        return button
    }()
    
    lazy var myImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "placeholder"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.text = "Date"
        return title
    }()
    
    let dateTextField: UITextField = {
        let title = UITextField()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.placeholder = "12.12.2012"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let detailLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.text = "Detail"
        return title
    }()
    
    let detailTextField: UITextView = {
        let title = UITextView()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.text = "Shrek is amazing!"
        title.translatesAutoresizingMaskIntoConstraints = false
        title.showsVerticalScrollIndicator = false
        return title
    }()
    
//    var addDelegate: AddToListDelegate?
    
    @objc private func handleSelectPhoto() {
        print("Trying to select photo..")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            myImage.image = editedImage
            
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myImage.image = originalImage
        }
        
        setupImage()
        
        dismiss(animated: true, completion: nil)
    }
    
    private func setupImage() {
        
        myImage.layer.cornerRadius = 5
        myImage.clipsToBounds = true
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Add Movie/Tv Show"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        addListButton.addTarget(self, action: #selector(handleAddingList), for: .touchUpInside)
        addMovieButton.addTarget(self, action: #selector(handleAddingName), for: .touchUpInside)
        
    }
    
    @objc private func handleSave() {
        
        guard let title = titleTextField.text else { return }
        guard let list = listTextField.text else { return }
        guard let date = dateTextField.text else { return }
        guard let detail = detailTextField.text else { return }
        guard let image = myImage.image else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let dateFormatted = dateFormatter.date(from: date) else {
            let alert = UIAlertController(title: "Shit", message: "Invalid Date", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "My Bad", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        
//        let context = CoreDataManager.shared.persistantContainer.viewContext
//        let watched = NSEntityDescription.insertNewObject(forEntityName: "Watched", into: context)
//
//        watched.setValue(title, forKey: "name")
//        watched.setValue(list, forKey: "list")
//        watched.setValue(dateFormatted, forKey: "date")
//        watched.setValue(detail, forKey: "detail")
//        watched.setValue(image.jpegData(compressionQuality: 0.8) as NSData?, forKey: "image")
        
        if titleTextField.text == "" {
            
            let alert = UIAlertController(title: "Shit", message: "Please add title", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sorry, Man", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        else {
//            do {
//                try context.save()
//                dismiss(animated: true) {
//                    self.addDelegate?.didAddToList(watched: watched as! Watched, listName: list)
//                }
//            }
//            catch {
//                print("Error saving watched", error)
//            }
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleAddingList() {
        
        let addListController = AddListController()
        let navController = UINavigationController(rootViewController: addListController)
        addListController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
    
    @objc private func handleAddingName() {
        let addNameController = AddNameController()
        addNameController.delegate = self
        let navController = UINavigationController(rootViewController: addNameController)
        
        present(navController, animated: true, completion: nil)
    }
    
    func selectedList(listName: String) {
        listTextField.text = listName
    }
    
    private func setupView() {
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(titleTextField)
        titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 3).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(addMovieButton)
        addMovieButton.topAnchor.constraint(equalTo: titleTextField.topAnchor).isActive = true
        addMovieButton.leadingAnchor.constraint(equalTo: titleTextField.trailingAnchor).isActive = true
        addMovieButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addMovieButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(listLabel)
        listLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20).isActive = true
        listLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        listLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        listLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(listTextField)
        listTextField.topAnchor.constraint(equalTo: listLabel.bottomAnchor).isActive = true
        listTextField.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor).isActive = true
        listTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        listTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor).isActive = true
        
        view.addSubview(addListButton)
        addListButton.topAnchor.constraint(equalTo: listTextField.topAnchor).isActive = true
        addListButton.leadingAnchor.constraint(equalTo: addMovieButton.leadingAnchor).isActive = true
        addListButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addListButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        view.addSubview(myImage)
        myImage.topAnchor.constraint(equalTo: listTextField.bottomAnchor, constant: 30).isActive = true
        myImage.leadingAnchor.constraint(equalTo: listTextField.leadingAnchor).isActive = true
        myImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        myImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: 30).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: myImage.leadingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(dateTextField)
        dateTextField.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        dateTextField.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(detailLabel)
        detailLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        detailLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(detailTextField)
        detailTextField.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 3).isActive = true
        detailTextField.leadingAnchor.constraint(equalTo: detailLabel.leadingAnchor, constant: 3).isActive = true
        detailTextField.trailingAnchor.constraint(equalTo: detailLabel.trailingAnchor).isActive = true
        detailTextField.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
}
