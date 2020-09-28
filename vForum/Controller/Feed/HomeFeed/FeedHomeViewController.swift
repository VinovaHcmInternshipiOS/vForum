//
//  FeedHomeViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class FeedHomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var likeStatus = Array(repeating: true, count: 20)
    var indexImage = Array(repeating: 0, count: 20)
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
        setConstraint()
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
            cell.reuseFeedCardView.setUpView()
            cell.reuseFeedCardView.clickLike = {
                if self.likeStatus[indexPath.row] {
                    cell.reuseFeedCardView.imageLiked.setImage(UIImage(named: "unlike"), for: .normal)
                    cell.reuseFeedCardView.setLikeCount(self.likeStatus[indexPath.row])
                    //cell.reuseFeedCardView.likeCount -= 1
                    self.likeStatus[indexPath.row] = false
                }
                else {
                    cell.reuseFeedCardView.imageLiked.setImage(UIImage(named: "like"), for: .normal)
                    cell.reuseFeedCardView.setLikeCount(self.likeStatus[indexPath.row])
                    //cell.reuseFeedCardView.likeCount += 1
                    self.likeStatus[indexPath.row] = true
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
    func fetchApi(){
        //AF.
        //Alamofire.req
    }
}
