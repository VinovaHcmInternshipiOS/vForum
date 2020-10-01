//
//  FeedDetailViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit
import SnapKit

class FeedDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reuseFeedCardDetail: ReuseFeedCard!
    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var tableViewSomeComments: UITableView!
    @IBOutlet weak var btnShowAllCmt: UIButton!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjZiZmQ5ZTRjMDFiYjQxODhjMTEyYzciLCJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwicm9sZSI6ImFkbWluIiwiZGlzcGxheV9uYW1lIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjAxNDc0NTM0LCJleHAiOjE2MDIwNzkzMzR9.Mk4ukqvcqYqJ2aOJadNe4TlvXMY5j7AifCCzZANSkK4"
    var number = 0
    var isLiked = true
    var feed: FeedHomeRequest?
    let remoteProvider = RemoteAPIProvider(configuration: FeedAppServerConfiguration.allTime)
    var commentArray: [FeedComment]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSomeComments.delegate = self
        tableViewSomeComments.dataSource = self
        tableViewSomeComments.register(UINib(nibName: "FeedDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedDetailTableViewCell")
        tableViewSomeComments.register(UINib(nibName: "NoCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "NoCommentTableViewCell")
        self.navigationItem.title = "Detail"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 20)!]
        reuseFeedCardDetail.lblUsername.text = feed?.createdBy
        reuseFeedCardDetail.lblContent.text = feed?.description
        reuseFeedCardDetail.lblLikeCount.text = String((feed?.countLike)!)
        reuseFeedCardDetail.commentAction = {
            let vc = FeedCommentViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        reuseFeedCardDetail.clickLike = {
            if self.isLiked {
                self.reuseFeedCardDetail.imageLiked.setImage(UIImage(named: "unlike"), for: .normal)
                self.isLiked = false
            }
            else {
                self.reuseFeedCardDetail.imageLiked.setImage(UIImage(named: "like"), for: .normal)
                self.isLiked = true
            }
        }
        reuseFeedCardDetail.toZoomScene = {
            let vcShowImageView = ShowImageViewController()
            //vcShowImageView.setImage(UIImage(named: "AppIcon")!)
            if #available(iOS 13.0, *) {
                vcShowImageView.image = UIImage(systemName: "person.circle.fill")
            } else {
                // Fallback on earlier versions
            }
            self.navigationController?.pushViewController(vcShowImageView, animated: true)
        }
        reuseFeedCardDetail.moreAction = {
            self.showMoreSheet()
        }
        callAPI()
    }
    
    @IBAction func SHOWALLCMT(_ sender: Any) {
        let vc = FeedCommentViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.commentArray = commentArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewSomeComments.reloadData()
    }
}

extension FeedDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number == 0 ? 1 : (number > 4 ? 4 : number)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if number == 0 {
            btnShowAllCmt.setTitle("Add new comments", for: .normal)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoCommentTableViewCell") as? NoCommentTableViewCell {
                return cell
            } else {
                return UITableViewCell()
            }
        }
        else {
            btnShowAllCmt.setTitle("Show all comments", for: .normal)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedDetailTableViewCell") as? FeedDetailTableViewCell {
                cell.reuseComment.lblUsername.text = self.commentArray?[indexPath.row].createdBy
                cell.reuseComment.lblContent.text = self.commentArray?[indexPath.row].description
                cell.reuseComment.moreAction = {
                    self.showMoreSheetComment()
                }
                return cell
            }
            else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableViewSomeComments.layoutIfNeeded()
        self.heightTableView.constant = self.tableViewSomeComments.contentSize.height
    }
}

extension FeedDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return number == 0 ? 100 : UITableView.automaticDimension
    }
}

extension FeedDetailViewController {
    func showMoreSheet() {
        let alert = UIAlertController(title: "More", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit")
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete")
            self.tableViewSomeComments.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Cancel")
            self.tableViewSomeComments.reloadData()
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func showMoreSheetComment() {
        let alert = UIAlertController(title: "More", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit")
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete")
            self.tableViewSomeComments.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Cancel")
            self.tableViewSomeComments.reloadData()
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
}

extension FeedDetailViewController {
    func callAPI(){
        remoteProvider.requestFreeJSON(target: FeedMethod.queryComment(feedID: (self.feed?._id)!), accessToken: self.token, fullfill: { (data) in
            print(data)
            do {
                if let result = data["result"] {
                    let dataResult = try JSONSerialization.data(withJSONObject: result, options: .fragmentsAllowed)
                    let decodable = JSONDecoder()
                    decodable.keyDecodingStrategy = .useDefaultKeys
                    decodable.dateDecodingStrategy = .millisecondsSince1970
                    self.commentArray = try decodable.decode([FeedComment].self, from: dataResult)
                    print(self.commentArray)
                }
            }
            catch let error {
                AlertView.showAlert(view: self, message: error.localizedDescription, title: "Error")
            }
//            for i in self.feedArray!{
//                self.likeCount.append(Int(i.countLike!))
//            }
            DispatchQueue.main.async {
                //self.number = Int((self.feed?.countCommentFeed)!)
                self.number = self.commentArray?.count as! Int
                self.tableViewSomeComments.reloadData()
            }
            //self.tableViewSomeComments.reloadData()
        }) { (err) in
            AlertView.showAlert(view: self, message: err.localizedDescription, title: "Error")
        }
        
    }
}
