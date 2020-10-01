//
//  CreationEventViewController.swift
//  vForum
//
//  Created by Phúc Lý on 9/24/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

extension CreationEventController {
    
    func initializeCancelBtn(_ cancelBtn: inout UIButton?) {
        cancelBtn = UIButton()
        guard let cancelBtn = cancelBtn else {
            return
        }
        view.addSubview(cancelBtn)
        
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cancelBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height * 0.04).isActive = true
        cancelBtn.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.2).isActive = true
        cancelBtn.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.06).isActive = true
        
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.setTitleColor(.red, for: .normal)
        cancelBtn.titleLabel?.font = UIFont(name: "Futura", size: self.view.bounds.height * 0.06 * 0.4)
        cancelBtn.addTarget(self, action: #selector(cancelBtnPressed(_:)), for: .touchUpInside)
    }
    
    func initializeSaveBtn(_ saveBtn: inout UIButton?) {
        saveBtn = UIButton()
        guard let saveBtn = saveBtn else {
            return
        }
        view.addSubview(saveBtn)
        
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        saveBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height * 0.04).isActive = true
        saveBtn.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.2).isActive = true
        saveBtn.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.06).isActive = true
        
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(.lightGray, for: .normal)
        saveBtn.titleLabel?.font = UIFont(name: "Futura", size: self.view.bounds.height * 0.06 * 0.4)
        saveBtn.addTarget(self, action: #selector(saveBtnPressed(_:)), for: .touchUpInside)
    }
    
    func initializeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView  else {
            return
        }
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.4).isActive = true
        collectionView.topAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "bannerEventCell")
        collectionView.backgroundColor = .lightGray
        
    }
    
    
    func initializeInputTextArea() {
        titleTextField = UITextField()
        descriptionTextField = UITextField()
        startDateLbl = UILabel()
        endDateLbl = UILabel()
        
        guard let titleTextField = titleTextField, let descriptionTextField = descriptionTextField, let startDateLbl = startDateLbl, let endDateLbl = endDateLbl, let cancelBtn = cancelBtn else {
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
        stack.topAnchor.constraint(equalTo: cancelBtn.bottomAnchor).isActive = true
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        titleTextField.placeholder = "Title"
        titleTextField.layer.cornerRadius = self.view.bounds.height * 0.4 * 0.02
        titleTextField.backgroundColor = .white
        titleTextField.delegate = self
        
        
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        descriptionTextField.placeholder = "Description"
        descriptionTextField.layer.cornerRadius = self.view.bounds.height * 0.4 * 0.02
        descriptionTextField.backgroundColor = .white
        descriptionTextField.delegate = self
        
        
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
