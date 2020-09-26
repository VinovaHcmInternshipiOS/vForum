//
//  NotificationViewController.swift
//  vForum
//
//  Created by Phúc Lý on 9/26/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierOfCell) else {
            return UITableViewCell()
        }
        let notification = listNotifications[indexPath.row]
        cell.textLabel?.text = notification
        return cell
    }
    
    
}
