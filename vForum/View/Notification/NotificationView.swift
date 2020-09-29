//
//  NotificationViewController.swift
//  vForum
//
//  Created by Phúc Lý on 9/26/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController {
    
    let listNotifications : [String] = []
    
    var tableView: UITableView?
    let typeOfCell = UITableViewCell.self
    let reuseIdentifierOfCell = "notificationCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        
        guard let tableView = tableView else {
            return
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(typeOfCell, forCellReuseIdentifier: reuseIdentifierOfCell)
        view.addSubview(tableView)
    }
}


