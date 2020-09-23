//
//  FeedHomeViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

class FeedHomeViewController: UIViewController {

    @IBOutlet weak var btnCreateFeed: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FeedHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedHomeTableViewCell")
        
    }
}

extension FeedHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedHomeTableViewCell") as? FeedHomeTableViewCell {
            return cell
        } else { return UITableViewCell()}
    }
}

extension FeedHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 610
    }
}
