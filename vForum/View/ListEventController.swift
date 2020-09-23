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

class ListEventController: UIViewController {
    var dropDown: DropDown?
    var isDrop: Bool = false
    var sortTypeBtn: UIButton?
    var sortDateBtn: UIButton?
    var tableView: UITableView?
    var navBarHeight: CGFloat = 70.0
    var listEvent: [EventCell] = [EventCell(title: "Event 1", description: "Description1", startDate: "15 April", endDate: "20 April", banner: "eventBannner")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        initializeSortTypeBtn(&sortTypeBtn)
        initializeSortDateBtn(&sortDateBtn)
        initializeTableView(&tableView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isDrop {
            dropDown?.hide()
        }
    }
    
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height * 0.1 + navBarHeight).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.9 - navBarHeight).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        
    }
    
    func initializeSortTypeBtn(_ sortType: inout UIButton?) {
        
        sortType = UIButton(frame: CGRect(x: 0, y: navBarHeight, width: view.bounds.width * 0.4, height: view.bounds.height * 0.1))
        
        guard let sortType = sortType else {
            return
        }
        
        sortType.setTitle("Sorting", for: .normal)
        sortType.titleLabel?.textAlignment = .center
        sortType.setTitleColor(UIColor(red: 171/255, green: 169/255, blue: 195/255, alpha: 1.0), for: .normal)
        sortType.addTarget(self, action: #selector(sortTypeBtnPressed(_:)), for: .touchUpInside)
        
        view.addSubview(sortType)
    }
    
    func initializeSortDateBtn(_ sortDate: inout UIButton?) {
        
        sortDate = UIButton(frame: CGRect(x: view.bounds.width * 0.5, y: navBarHeight, width: view.bounds.width * 0.4, height: view.bounds.height * 0.1))// getSortDate(self.view, "15 April")
        
        guard let sortDate = sortDate else {
            return
        }
        
        sortDate.setTitle("15 April", for: .normal)
        sortDate.titleLabel?.textAlignment = .center
        sortDate.setTitleColor(UIColor(red: 171/255, green: 169/255, blue: 195/255, alpha: 1.0), for: .normal)
        sortDate.addTarget(self, action: #selector(sortDateBtnPressed(_:)), for: .touchUpInside)
        
        view.addSubview(sortDate)
    }
    
    @objc func sortDateBtnPressed(_ sender: UIButton) {
        let datePickerView = DatePickerEvent()
        datePickerView.modalPresentationStyle = .popover
        
        self.present(datePickerView, animated: true, completion: nil)
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
    
}

extension ListEventController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventTableViewCell
        let event = listEvent[indexPath.row]
        cell.frame.size.height = tableView.rowHeight
        cell.initializeContainer()
        cell.initializeTitle(event.title)
        cell.initializeDateTime("\(event.startDate) - \(event.endDate)")
        cell.background = event.banner
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailEvent = DetailEvent()
        detailEvent.modalPresentationStyle = .popover
        DispatchQueue.main.async {
            self.present(detailEvent, animated: true, completion: nil)
        }
    }
    
    
}
