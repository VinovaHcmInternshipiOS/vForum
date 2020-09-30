//
//  RemindViewController.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repeatCell")!
        cell.textLabel?.text = options[indexPath.row].toString()
        cell.accessoryType = chose == options[indexPath.row] ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chose = options[indexPath.row]
        if let changeRemindTime = changeRemindTime, let chose = chose {
            changeRemindTime(chose)
            tableView.reloadData()

            // TODO: Update remind time to database
        }
        
    }
    
}
