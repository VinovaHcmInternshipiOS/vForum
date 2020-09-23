//
//  FeedCommentViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

class FeedCommentViewController: UIViewController {
    @IBOutlet weak var tableViewCmts: UITableView!
    @IBOutlet weak var txtviewAddCmt: UITextView!
    @IBOutlet weak var btnSendCmt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCmts.delegate = self
        tableViewCmts.dataSource = self
        tableViewCmts.register(UINib(nibName: "FeedCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedCommentTableViewCell")
        self.navigationItem.title = "Comment"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 20)!]
    }

    @IBAction func ADDCOMMENT(_ sender: Any) {
        //TODO:
    }
}

extension FeedCommentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension FeedCommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO:
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCommentTableViewCell") as? FeedCommentTableViewCell {
            //TODO:
            return cell
        } else { return UITableViewCell()}
    }
}
