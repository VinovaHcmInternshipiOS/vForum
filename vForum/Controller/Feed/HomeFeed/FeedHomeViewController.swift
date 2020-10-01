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
    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjZiZmQ5ZTRjMDFiYjQxODhjMTEyYzciLCJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwicm9sZSI6ImFkbWluIiwiZGlzcGxheV9uYW1lIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjAxNDc0NTM0LCJleHAiOjE2MDIwNzkzMzR9.Mk4ukqvcqYqJ2aOJadNe4TlvXMY5j7AifCCzZANSkK4"
    var likeStatus = Array(repeating: false, count: 20)
    var indexImage = Array(repeating: 0, count: 20)
    var likeCount = Array(repeating: 0, count: 20)
    var feedArray: [FeedHomeRequest]?
    //var imageArrayCell: [UIImage]?
    var imageArray: [[UIImage]] = Array(repeating: [], count: 20)
    //var imageArrayIndex = 0
    let remoteProvider = RemoteAPIProvider(configuration: FeedAppServerConfiguration.allTime)
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
        setConstraint()
        callAPI()
    }
}

extension FeedHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedHomeTableViewCell") as? FeedHomeTableViewCell {
            if imageArray[indexPath.row].count == 0 {
                if let urlArray = (self.feedArray?[indexPath.row].attachments)! as [String]? {
                    downloadImage(urlArray: urlArray) { imgs in
                        cell.reuseFeedCardView.setData(imgs)
                        self.imageArray[indexPath.row] = imgs
                    }
                }
            }
            else {
                cell.reuseFeedCardView.setData(imageArray[indexPath.row])
            }
            cell.reuseFeedCardView.lblTimeCreate.text = self.feedArray?[indexPath.row].createdAt?.stringToDate8601().toLocalTime().timeAgoDisplay()
            //print("Date: \()")
            cell.reuseFeedCardView.liked = likeStatus[indexPath.row]
            cell.reuseFeedCardView.index = indexImage[indexPath.row]
            cell.reuseFeedCardView.likeCount = likeCount[indexPath.row]
            cell.reuseFeedCardView.lblUsername.text = self.feedArray?[indexPath.row].createdBy
            cell.reuseFeedCardView.lblContent.text = self.feedArray?[indexPath.row].description
            cell.reuseFeedCardView.lblCommentCount.text =
                String((self.feedArray?[indexPath.row].countCommentFeed)!) + "comments"
            cell.reuseFeedCardView.setUpView()
            cell.reuseFeedCardView.clickLike = {
                if self.likeStatus[indexPath.row] {
                    cell.reuseFeedCardView.imageLiked.setImage(UIImage(named: "notlike"), for: .normal)
                    cell.reuseFeedCardView.setLikeCount(self.likeStatus[indexPath.row])
                    //cell.reuseFeedCardView.likeCount -= 1
                    self.likeStatus[indexPath.row] = false
                    self.likeCount[indexPath.row] = self.likeCount[indexPath.row] > 0 ? self.likeCount[indexPath.row] - 1 : self.likeCount[indexPath.row]
                    self.minusLikeAPI((self.feedArray?[indexPath.row]._id)!)
                }
                else {
                    cell.reuseFeedCardView.imageLiked.setImage(UIImage(named: "like"), for: .normal)
                    cell.reuseFeedCardView.setLikeCount(self.likeStatus[indexPath.row])

                    //cell.reuseFeedCardView.likeCount += 1
                    self.likeStatus[indexPath.row] = true
                    self.likeCount[indexPath.row] += 1
                    self.addLikeAPI((self.feedArray?[indexPath.row]._id)!)
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
                self.showMoreSheet(indexPath, indexPath.row, self.imageArray[indexPath.row], cell.reuseFeedCardView.lblContent.text ?? "")
            }
            return cell
        } else { return UITableViewCell()}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FeedDetailViewController()
        vc.feed = self.feedArray?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FeedHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FeedHomeViewController {
    @objc func CREATEFEED(sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(FeedCreateViewController(), animated: true)
    }
}

extension FeedHomeViewController {
    func showMoreSheet(_ indexPath: IndexPath,_ row: Int,_ imageArray: [UIImage], _ description: String) {
        let alert = UIAlertController(title: "More", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit")
            let vc = FeedEditCardViewController()
            vc.reload = {
                self.tableView.reloadData()
            }
            vc.imageArray = imageArray
            vc.txtView.text = description
            self.navigationController?.pushViewController(vc, animated: true)
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete")
            self.showAlertDelete(indexPath, row)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Cancel")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

    func showAlertDelete(_ indexPath: IndexPath,_ row: Int){
        let alert = UIAlertController(title: "Warning", message: "Are you sure to delete this feed?\nYou can't restore it if you delete.",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete",
                                      style: .destructive,
                                      handler: {(_: UIAlertAction!) in
            self.feedArray?.remove(at: row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
            self.deleteFeedAPI((self.feedArray?[row]._id)!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension FeedHomeViewController {
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
    func downloadImage(urlArray: [String], receivedAllImgHandler: @escaping ([UIImage])->Void){
        var imgArray: [UIImage] = []
        for imgUrl in urlArray {
            guard let url = URL(string: imgUrl) else {
                return
            }
            let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
                guard let data = data, error == nil else {
                    AlertView.showAlert(view: self, message: error!.localizedDescription, title: "Error")
                    return
                }

                if let imageReturn = UIImage(data: data) {
                    imgArray.append(imageReturn)
                }
                
                if imgArray.count == urlArray.count {
                    DispatchQueue.main.async {
                        receivedAllImgHandler(imgArray)
                    }
                }
            })
            task.resume()
        }
    }
}

extension FeedHomeViewController {
    func callAPI(){
        remoteProvider.requestFreeJSON(target: FeedMethod.query, accessToken: self.token, fullfill: { (data) in
            //print("JSON: \(data)")
            do {
                if let result = data["result"] {
                    let dataResult = try JSONSerialization.data(withJSONObject: result, options: .fragmentsAllowed)
                    let decodable = JSONDecoder()
                    decodable.keyDecodingStrategy = .useDefaultKeys
                    decodable.dateDecodingStrategy = .millisecondsSince1970
                    self.feedArray = try decodable.decode([FeedHomeRequest].self, from: dataResult)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print(self.feedArray?[0].commentsFeed)
                }
            }
            catch let error {
                AlertView.showAlert(view: self, message: error.localizedDescription, title: "Error")
            }
            for i in self.feedArray!{
                self.likeCount.append(Int(i.countLike!))
            }
            self.tableView.reloadData()
        }) { (err) in
            AlertView.showAlert(view: self, message: err.localizedDescription, title: "Error")
        }
//        remoteProvider.request(target: FeedMethod.query, accessToken: "", fullfill: { (returnData: [FeedRequestMethod]?) in
//            print(returnData?.count)
//                }) { (Error) in
//                    print(Error)
//                }
    }
    
    func addLikeAPI(_ feedID: String){
        remoteProvider.requestFreeJSON(target: FeedMethod.addLike(feedID: feedID), accessToken: self.token, fullfill: { (data) in
            print(data)})
        { (err) in
            AlertView.showAlert(view: self, message: err.localizedDescription, title: "Error")
        }
    }
    
    func minusLikeAPI(_ feedID: String){
        remoteProvider.requestFreeJSON(target: FeedMethod.minusLike(feedID: feedID), accessToken: self.token, fullfill: { (data) in
            print(data)})
        { (err) in
            AlertView.showAlert(view: self, message: err.localizedDescription, title: "Error")
        }
    }
    
    func deleteFeedAPI(_ feedID: String){
        remoteProvider.requestFreeJSON(target: FeedMethod.deleteFeed(feedID: feedID), accessToken: self.token, fullfill: { (data) in
            print(data)})
        { (err) in
            AlertView.showAlert(view: self, message: err.localizedDescription, title: "Error")
        }
    }
}
