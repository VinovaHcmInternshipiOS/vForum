//
//  ListEventController.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit
import DropDown

extension ListEventController {
    // Detect touch to turn off drop down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isDrop {
            dropDown?.hide()
        }
    }
    
    @objc func addEventBtnPressed(_ sender: UIBarButtonItem) {
        let creationEvent = CreationEventController()

        self.navigationController?.pushViewController(creationEvent, animated: true)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.listEvent.removeAll()
            self.listEvent = EventManager.shared.getEvents()
            self.refreshControl.endRefreshing()
            self.tableView?.reloadData()
        }
    }
    
    
    @objc func sortTypeBtnPressed(_ sender: UIButton) {
        dropDown = DropDown()
        
        guard let dropDown = dropDown else {
            return
        }
        isDrop = true
        dropDown.anchorView = sender
        dropDown.dataSource =  ["Passed", "Oldest", "Newest"]
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
          sender.setTitle(item, for: .normal) //9
            self?.isDrop = false
        }
    }
    
    @objc func sortDateBtnPressed(_ sender: UIButton) {
        let datePickerView = DateTimePickerEvent()
        datePickerView.modalPresentationStyle = .popover
        
        self.present(datePickerView, animated: true, completion: nil)
    }
}


// Tableview Delegates
extension ListEventController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventTableViewCell
        let event = listEvent[indexPath.row]
        cell.frame.size.height = tableView.rowHeight
        cell.event = event
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailEvent = DetailEventController()
        detailEvent.modalPresentationStyle = .popover
        detailEvent.event = listEvent[indexPath.row]
        DispatchQueue.main.async {
            self.present(detailEvent, animated: true, completion: nil)
        }
    }
    
    
}