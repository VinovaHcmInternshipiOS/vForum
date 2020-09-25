//
//  RepeatPickerView.swift
//  vForum
//
//  Created by Phúc Lý on 9/24/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class RemindViewController: UIViewController {
    
    var tableView: UITableView?
    var chose: RepeatedlyEvent?
    var options: [RepeatedlyEvent] = [.hourly, .daily, .weekly, .monthly, ._3months, ._6months, .yearly]
    
    var changeRemindTime: ((RepeatedlyEvent) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView(&tableView)
    }
    
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

