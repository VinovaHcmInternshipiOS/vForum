//
//  RepeatPickerView.swift
//  vForum
//
//  Created by Phúc Lý on 9/24/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

extension RemindViewController: UITableViewDelegate, UITableViewDataSource {

    func initializeTableView(_ tableView: inout UITableView?) {
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        guard let tableView = tableView else {
            return
        }
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "repeatCell")
    }

    
}

