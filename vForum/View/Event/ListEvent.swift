//
//  ListEventController.swift
//  vForum
//
//  Created by Phúc Lý on 9/23/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit
import DropDown

extension ListEventController {
    // Add Bar Button
    func initializeAddEventBtn() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ListEventController.addEventBtnPressed(_:)))
    }
    
    // Table View
    func initializeTableView(_ tableView: inout UITableView?) {
        tableView = UITableView(frame: .zero, style: .grouped)
        guard let tableView = tableView else {
            return
        }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "eventCell")
        tableView.rowHeight = 80.0
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        refreshControl.addTarget(self, action: #selector(ListEventController.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height * 0.05 + navBarHeight).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.9 - navBarHeight).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        
    }
    
    // Sort Type Button
    func initializeSortTypeBtn(_ sortType: inout UIButton?) {
        
        sortType = UIButton(frame: CGRect(x: 0, y: navBarHeight, width: view.bounds.width * 0.4, height: view.bounds.height * 0.05))
        
        guard let sortType = sortType else {
            return
        }
        
        sortType.setTitle("Sorting", for: .normal)
        sortType.titleLabel?.textAlignment = .center
        sortType.setTitleColor(UIColor(red: 171/255, green: 169/255, blue: 195/255, alpha: 1.0), for: .normal)
        sortType.addTarget(self, action: #selector(sortTypeBtnPressed(_:)), for: .touchUpInside)
        
        view.addSubview(sortType)
    }
    
    // Sort Date Button
    func initializeSortDateBtn(_ sortDate: inout UIButton?) {
        
        sortDate = UIButton(frame: CGRect(x: view.bounds.width * 0.5, y: navBarHeight, width: view.bounds.width * 0.4, height: view.bounds.height * 0.05))// getSortDate(self.view, "15 April")
        
        guard let sortDate = sortDate else {
            return
        }
        
        sortDate.setTitle("Date-Date", for: .normal)
        sortDate.titleLabel?.textAlignment = .center
        sortDate.setTitleColor(UIColor(red: 171/255, green: 169/255, blue: 195/255, alpha: 1.0), for: .normal)
        sortDate.addTarget(self, action: #selector(sortDateBtnPressed(_:)), for: .touchUpInside)
        
        view.addSubview(sortDate)
    }
    
    
}


