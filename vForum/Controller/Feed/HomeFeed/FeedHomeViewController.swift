//
//  FeedHomeViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

class FeedHomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FeedHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedHomeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 13.0, *) {
            let btnCreate = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(CREATEFEED))
            btnCreate.tintColor = .black
            self.navigationItem.rightBarButtonItem  = btnCreate
        } else {
            // Fallback on earlier versions
        }
        self.navigationItem.title = "Feed"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 20)!]
        let leftItem = UIBarButtonItem(title: "Vforum",
                                       style: UIBarButtonItem.Style.plain,
                                       target: nil,
                                       action: nil)
        leftItem.tintColor = .black
        leftItem.titleTextAttributes(for: .normal)
        self.navigationItem.leftBarButtonItem = leftItem
    }
}

extension FeedHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO:
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedHomeTableViewCell") as? FeedHomeTableViewCell {
            //TODO:
            return cell
        } else { return UITableViewCell()}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(FeedDetailViewController(), animated: true)
    }
}

extension FeedHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TODO:
        return 610
    }
    
    
}

extension FeedHomeViewController {
    @objc func CREATEFEED(sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(FeedCreateViewController(), animated: true)
    }
}
