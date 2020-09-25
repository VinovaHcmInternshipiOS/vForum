//
//  CreationEventViewController.swift
//  vForum
//
//  Created by Phúc Lý on 9/24/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class CreationEventViewController: UIViewController {
//    let saveBarBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(CreationEventViewController.saveBarBtnPressed(_:)))
    var addEvent: ((Event) -> Void)?
    
    var titleTextField: UITextField?
    var descriptionTextField: UITextField?
    var startDateLbl: UILabel?
    var endDateLbl: UILabel?
    var collectionView: UICollectionView?
    var banner: String?
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initializeInputTextArea()
        initializeCollectionView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(CreationEventViewController.saveBarBtnPressed(_:)))
    }
    
    func initializeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.4).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height ?? 60) * 2.0 + self.view.bounds.height * 0.4).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "bannerEventCell")
        collectionView.backgroundColor = .lightGray
        
    }
    
    
    func initializeInputTextArea() {
        let stack = UIStackView()
        titleTextField = UITextField()
        descriptionTextField = UITextField()
        startDateLbl = UILabel()
        endDateLbl = UILabel()
        
        guard let titleTextField = titleTextField, let descriptionTextField = descriptionTextField, let startDateLbl = startDateLbl, let endDateLbl = endDateLbl else {
            return
        }
        
        stack.addArrangedSubview(titleTextField)
        stack.addArrangedSubview(descriptionTextField)
        stack.addArrangedSubview(startDateLbl)
        stack.addArrangedSubview(endDateLbl)
        view.addSubview(stack)
        
        
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width * 0.05).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.view.bounds.width * 0.05).isActive = true
        stack.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.4).isActive = true
        stack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height ?? 60) * 2.0).isActive = true
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        titleTextField.placeholder = "Title"
        titleTextField.layer.cornerRadius = self.view.bounds.height * 0.4 * 0.02
        titleTextField.backgroundColor = .white
        
        
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        descriptionTextField.placeholder = "Description"
        descriptionTextField.layer.cornerRadius = self.view.bounds.height * 0.4 * 0.02
        descriptionTextField.backgroundColor = .white
        
        
        startDateLbl.translatesAutoresizingMaskIntoConstraints = false
        startDateLbl.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        startDateLbl.text = "dd-mm-yyyy"
        startDateLbl.layer.cornerRadius = self.view.bounds.height * 0.4 * 0.02
        startDateLbl.backgroundColor = .white
        startDateLbl.isUserInteractionEnabled = true
        startDateLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToDateTimePicker(sender:)) ))
        
        
        endDateLbl.translatesAutoresizingMaskIntoConstraints = false
        endDateLbl.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        endDateLbl.text = "dd-mm-yyyy"
        endDateLbl.layer.cornerRadius = self.view.bounds.height * 0.4 * 0.02
        endDateLbl.backgroundColor = .white
        endDateLbl.isUserInteractionEnabled = true
        endDateLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToDateTimePicker(sender:)) ))
    }
}


extension CreationEventViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width * 0.25, height: self.view.bounds.width * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventManager.shared.listBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerEventCell", for: indexPath)
        let imageView = UIImageView(image: UIImage(named: EventManager.shared.listBanner[indexPath.row]))
        imageView.contentMode = .scaleToFill
        imageView.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(imageView)
        cell.layer.borderWidth = selectedIndex == indexPath ? 5.0 : 0.0
        cell.layer.borderColor = UIColor.blue.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        banner = EventManager.shared.listBanner[indexPath.row]
        selectedIndex = indexPath
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    @objc func moveToDateTimePicker(sender: UITapGestureRecognizer) {
        let datePicker = DatePickerEvent()
        datePicker.chooseDateTime = { startDate, endDate in
//            let current = Calendar.current
            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy 'T' HH:mm"
            
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            self.startDateLbl?.text = dateFormatter.string(from: startDate)
            self.endDateLbl?.text = dateFormatter.string(from: endDate)
            
        }
        present(datePicker, animated: true, completion: nil)
    }
    
    @objc func saveBarBtnPressed(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextField?.text, let description = descriptionTextField?.text, let startDate = startDateLbl?.text, let endDate = endDateLbl?.text, let banner = banner else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        guard let start = dateFormatter.date(from: startDate), let end = dateFormatter.date(from: endDate) else {
            return
        }
        
        let event = EventManager.shared.createEvent(title: title, description: description, startDate: start, endDate: end, banner: banner)
//        
//        if let addEvent = addEvent {
//            addEvent(event)
//        }
//        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
        }
    }

    
}


