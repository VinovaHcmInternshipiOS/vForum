//
//  ForumGroupController.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class ForumGroupController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TopicList: UITableView!
    
    var titles:[String] = ["Help with UINavigationController", "iOS 14.0: Is it good?", "This is great", "Tutorials"]
    var creators:[String] = ["aland","dominic","curtis","timon"]
    var postCounts:[Int] = [35,950,1212,75560]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopicList.backgroundColor = .clear
        
        TopicList.register(UINib(nibName: "TopicCellView", bundle: nil), forCellReuseIdentifier: "TopicCell")
        
        TopicList.delegate = self
        TopicList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
    
        cell.initCell()
        cell.setTitle(titles[indexPath.row])
        cell.setPostCount(postCounts[indexPath.row])
        cell.setCreator(creators[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PostDetailViewController(nibName: "PostDetailViewController", bundle: nil)
        //vc.setTitle(titles[indexPath.row])
        //vc.setSubtitle(name: creators[indexPath.row], date: "20/09/2020, 07:00")
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopicCell
    
        cell.MainView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopicCell
        
        cell.MainView.backgroundColor = UIColor.white
        
    }
    
}


