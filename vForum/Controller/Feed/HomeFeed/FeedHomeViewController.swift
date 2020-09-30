//
//  FeedHomeViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit
import SnapKit

class FeedHomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var accessToken = ""
    var likeStatus = Array(repeating: false, count: 20)
    var indexImage = Array(repeating: 0, count: 20)
    var likeCount = Array(repeating: 0, count: 20)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FeedHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedHomeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
//        NotificationCenter.default.addObserver(self, selector: #selector(getAccessToken), name: NSNotification.Name(rawValue: NSNotification.Name.getAccessToken.rawValue), object: nil)
        
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
        accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        print(accessToken)
        setConstraint()
        callAPI()
    }
}

extension FeedHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedHomeTableViewCell") as? FeedHomeTableViewCell {
            cell.reuseFeedCardView.liked = likeStatus[indexPath.row]
            cell.reuseFeedCardView.index = indexImage[indexPath.row]
            cell.reuseFeedCardView.likeCount = likeCount[indexPath.row]
            cell.reuseFeedCardView.setUpView()
            cell.reuseFeedCardView.clickLike = {
                if self.likeStatus[indexPath.row] {
                    cell.reuseFeedCardView.imageLiked.setImage(UIImage(named: "notlike"), for: .normal)
                    cell.reuseFeedCardView.setLikeCount(self.likeStatus[indexPath.row])
                    self.likeStatus[indexPath.row] = false
                    self.likeCount[indexPath.row] = self.likeCount[indexPath.row] > 0 ? self.likeCount[indexPath.row] - 1 : self.likeCount[indexPath.row]
                }
                else {
                    cell.reuseFeedCardView.imageLiked.setImage(UIImage(named: "like"), for: .normal)
                    cell.reuseFeedCardView.setLikeCount(self.likeStatus[indexPath.row])
                    self.likeStatus[indexPath.row] = true
                    self.likeCount[indexPath.row] += 1
                }
            }
            cell.reuseFeedCardView.scrollAction = {
                self.indexImage[indexPath.row] = cell.reuseFeedCardView.index
            }
            cell.reuseFeedCardView.toZoomScene = {
                let vc = ShowImageViewController()
                if #available(iOS 13.0, *) {
                    vc.setImage(UIImage(systemName: "person.circle.fill")!)
                } else {
                    // Fallback on earlier versions
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.reuseFeedCardView.commentAction = {
                self.navigationController?.pushViewController(FeedDetailViewController(), animated: true)
            }
            cell.reuseFeedCardView.moreAction = {
                self.showMoreSheet()
            }
            return cell
        } else { return UITableViewCell()}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(FeedDetailViewController(), animated: true)
    }
}

extension FeedHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FeedHomeViewController {
    @objc func CREATEFEED(sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(FeedCreateViewController(), animated: true)
    }
    
    func setConstraint(){
        tableView.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension FeedHomeViewController {
    @objc func getAccessToken(notification: Notification) {
        if let data = notification.userInfo as? [String: Any] {
            print(data)
        }
    }
}

extension FeedHomeViewController {
    func callAPI(){
        RemoteAPIProvider.testingMethod(accessToken, "http://localhost:4000/v1/api/feed")
    }
    
    func showMoreSheet() {
        let alert = UIAlertController(title: "More", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit")
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete")
            self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Cancel")
            self.tableView.reloadData()
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}
