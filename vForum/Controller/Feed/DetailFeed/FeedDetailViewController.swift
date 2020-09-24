//
//  FeedDetailViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reuseFeedCardDetail: ReuseFeedCard!
    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var tableViewSomeComments: UITableView!
    @IBOutlet weak var btnShowAllCmt: UIButton!
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSomeComments.delegate = self
        tableViewSomeComments.dataSource = self
        tableViewSomeComments.register(UINib(nibName: "FeedDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedDetailTableViewCell")
        self.navigationItem.title = "Detail"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 20)!]
        // Do any additional setup after loading the view.
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func SHOWALLCMT(_ sender: Any) {
        self.navigationController?.pushViewController(FeedCommentViewController(), animated: true)
    }
}

extension FeedDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedDetailTableViewCell") as? FeedDetailTableViewCell {
            //TODO:
            return cell
        } else { return UITableViewCell()}
    }
}

extension FeedDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FeedDetailViewController {
    func setConstraints(){
       scrollView.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        reuseFeedCardDetail.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(viewContain.snp_top)
            make.left.equalTo(viewContain.snp_left)
            make.right.equalTo(viewContain.snp_right)
            //make.bottom.equalToSuperview()
        }
        tableViewSomeComments.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(reuseFeedCardDetail.snp_bottom)
            make.left.equalTo(viewContain.snp_left)
            make.right.equalTo(viewContain.snp_right)
            make.height.equalToSuperview().multipliedBy(0.3)
            //make.bottom.equalToSuperview()
        }
        btnShowAllCmt.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(tableViewSomeComments.snp_bottom).offset(10)
            make.left.equalTo(viewContain.snp_left).offset(30)
            make.bottom.equalTo(viewContain.snp_bottom).offset(-30)
        }
    }
}

extension FeedDetailViewController {
    
    
    
}
