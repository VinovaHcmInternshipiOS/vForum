//
//  FeedDetailViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {

    @IBOutlet weak var reuseFeedCardDetail: ReuseFeedCard!
    @IBOutlet weak var tableViewSomeComments: UITableView!
    @IBOutlet weak var btnShowAllCmt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 20)!]
        // Do any additional setup after loading the view.
    }

    @IBAction func SHOWALLCMT(_ sender: Any) {
        self.navigationController?.pushViewController(FeedCommentViewController(), animated: true)
    }
}
