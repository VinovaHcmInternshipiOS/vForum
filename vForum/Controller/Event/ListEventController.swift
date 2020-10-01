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

class ListEventController: UIViewController {
    var dropDown: DropDown?
    var isDrop: Bool = false
    var sortTypeBtn: UIButton?
    var sortDateBtn: UIButton?
    var tableView: UITableView?
    var navBarHeight: CGFloat = 70.0
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var listEvent: [Event] = EventManager.shared.getEvents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        initializeSortTypeBtn(&sortTypeBtn)
        initializeSortDateBtn(&sortDateBtn)
        initializeTableView(&tableView)
        initializeAddEventBtn()
        
    }
    // Detect touch to turn off drop down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isDrop {
            dropDown?.hide()
        }
    }
    
    @objc func addEventBtnPressed(_ sender: UIBarButtonItem) {
        let creationEvent = CreationEventController()
        creationEvent.addEvent = { (event) in
            self.sortTypeBtn?.setTitle("Sorting", for: .normal)
            self.listEvent.removeAll()
            self.listEvent = EventManager.shared.getEvents()
            self.tableView?.reloadData()
        }
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
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
          guard let _ = self else { return }
          sender.setTitle(item, for: .normal)
            if item == "Passed" {
                self?.listEvent = EventManager.shared.getPassedEvents()
                self?.tableView?.reloadData()
            }
            else if item == "Oldest" {
                self?.listEvent = EventManager.shared.getOldestEvents()
                self?.tableView?.reloadData()
            }
            else if item == "Newest" {
                self?.listEvent = EventManager.shared.getNewestEvents()
                self?.tableView?.reloadData()
            }
            self?.isDrop = false
        }
    }
    
    @objc func sortDateBtnPressed(_ sender: UIButton) {
        let datePickerView = DateTimePickerEvent()
        datePickerView.modalPresentationStyle = .popover
        datePickerView.isSorting = true
        datePickerView.sortDateTime = { (from, to) in
            self.listEvent = EventManager.shared.getEvents(from: from, to: to)
            self.tableView?.reloadData()
        }
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
        detailEvent.modalPresentationStyle = .fullScreen
        detailEvent.event = listEvent[indexPath.row]
        detailEvent.editEvent  = {
            self.listEvent = EventManager.shared.getEvents()
            self.tableView?.reloadData()
        }
        DispatchQueue.main.async {
            self.present(detailEvent, animated: true, completion: nil)
        }
    }
    
    
}
