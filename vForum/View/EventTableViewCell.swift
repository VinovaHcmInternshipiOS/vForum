//
//  EventTableViewCell.swift
//  vForum
//
//  Created by Phúc Lý on 9/23/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class EventTableViewCell: UITableViewCell {
    var container: UIView?
    var marginSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 10
    var title: UILabel?
    var dateTime: UILabel?
    var background: String? {
        didSet {
            guard let background = background, let container = container else {
                return
            }
            
            let _img = UIImage(named: background)
            
            guard let image = _img else {
                return
            }
            
            container.backgroundColor = UIColor(patternImage: image)
            container.alpha = 0.2
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeContainer() {
        container = UIView()
        
        guard let container = container else {
            return
        }
        self.addSubview(container)
        
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.9).isActive = true
        container.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.9).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        container.center = self.center
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
        title.font = UIFont(name: "Futura", size: self.bounds.height * 0.5 * 0.7)
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
        dateTime.font = UIFont(name: "Futura", size: self.bounds.height * 0.5 * 0.4)
        dateTime.text = text
    }
    
}
