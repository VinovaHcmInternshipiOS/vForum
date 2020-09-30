//
//  EventTableViewCell.swift
//  vForum
//
//  Created by Phúc Lý on 9/23/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

extension EventTableViewCell {
    
    func initializeContainer() {
        container = UIView()
        
        guard let container = container else {
            return
        }
        self.addSubview(container)
        
        
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: marginSpace).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -marginSpace).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: marginSpace).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -marginSpace).isActive = true
        
        container.layer.cornerRadius = bounds.height * 0.1
    }
    
    func initializeTitle(_ text: String) {
        title = UILabel()
            
        guard let title = title, let container = container else {
            return
        }
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: marginSpace).isActive = true
        title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -marginSpace).isActive = true
        title.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.5).isActive = true
        
        
        title.textColor = .black
        title.font = UIFont(name: "Futura", size: self.bounds.height * 0.5 )
        title.text = text
    }
        
    func initializeDateTime(_ text: String) {
        dateTime = UILabel()
        
        guard let dateTime = dateTime, let container = container, let title = title else {
            return
        }
        self.addSubview(dateTime)
        
        dateTime.translatesAutoresizingMaskIntoConstraints = false
        dateTime.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: marginSpace).isActive = true
        dateTime.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -marginSpace).isActive = true
        dateTime.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        dateTime.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        dateTime.textColor = .black
        dateTime.font = UIFont(name: "Futura", size: self.bounds.height * 0.5)
        dateTime.text = text
    }
    
}
