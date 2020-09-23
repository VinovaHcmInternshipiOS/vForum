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
    
    var sortTypeBtn: UIButton?
    var sortDateBtn: UIButton?
    var tableView: UITableView?
    var navBarHeight: CGFloat = 70.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        initializeSortTypeBtn(&sortTypeBtn)
        initializeSortDateBtn(&sortDateBtn)
        
    }
    
    func initializeSortTypeBtn(_ sortType: inout UIButton?) {
        
        sortType = UIButton(frame: CGRect(x: 0, y: navBarHeight, width: view.bounds.width * 0.4, height: view.bounds.height * 0.1))
        
        guard let sortType = sortType else {
            return
        }
        
        sortType.setTitle("Sorting", for: .normal)
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
        sortDate.setTitleColor(UIColor(red: 171/255, green: 169/255, blue: 195/255, alpha: 1.0), for: .normal)
        sortDate.addTarget(self, action: #selector(sortDateBtnPressed(_:)), for: .touchUpInside)
        
        view.addSubview(sortDate)
    }
    
    @objc func sortDateBtnPressed(_ sender: UIButton) {
        
    }
    
    @objc func sortTypeBtnPressed(_ sender: UIButton) {
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource =  ["Passed", "Oldest", "Newest"]
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
          sender.setTitle(item, for: .normal) //9
        }
    }
    
}
