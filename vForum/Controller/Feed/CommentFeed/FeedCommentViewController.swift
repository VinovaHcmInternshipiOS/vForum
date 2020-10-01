//
//  FeedCommentViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit
import SnapKit

class FeedCommentViewController: UIViewController {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var tableViewCmts: UITableView!
    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var txtviewAddCmt: UITextView!
    @IBOutlet weak var btnSendCmt: UIButton!
    var commentArray: [FeedComment]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCmts.delegate = self
        tableViewCmts.dataSource = self
        tableViewCmts.register(UINib(nibName: "FeedCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedCommentTableViewCell")
        tableViewCmts.register(UINib(nibName: "NoCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "NoCommentTableViewCell")
        txtviewAddCmt.delegate = self
        self.navigationItem.title = "Comment"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 20)!]
        setConstraint()
        setLayer()
        btnSendCmt.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func ADDCOMMENT(_ sender: Any) {
        txtviewAddCmt.text = "Type somethings ..."
        btnSendCmt.isEnabled = false
        keyboardWillHide(notification: NSNotification(name: UIResponder.keyboardWillHideNotification, object: nil))
        view.endEditing(true)
    }
}

extension FeedCommentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return commentArray == nil ? tableView.layer.frame.height : UITableView.automaticDimension
    }
}

extension FeedCommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if commentArray == nil {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoCommentTableViewCell") as? NoCommentTableViewCell {
                return cell
            } else { return UITableViewCell()}
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCommentTableViewCell") as? FeedCommentTableViewCell {
                cell.reuseComment.lblUsername.text = self.commentArray?[indexPath.row].createdBy
                cell.reuseComment.lblContent.text = self.commentArray?[indexPath.row].description
                cell.reuseComment.moreAction = {
                    self.showMoreSheetComment()
                }
                return cell
            } else { return UITableViewCell()}
        }
    }
}

extension FeedCommentViewController {
    func setConstraint(){
        viewBackground.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        tableViewCmts.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
        }
        viewContain.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(tableViewCmts.snp_bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.08)
        }
        txtviewAddCmt.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(viewContain.snp_top).offset(10)
            make.left.equalTo(viewContain.snp_left).offset(10)
            make.width.equalTo(viewContain).multipliedBy(0.8)
            make.height.equalTo(viewContain).multipliedBy(0.8)
        }
        btnSendCmt.snp.makeConstraints{ (make)->Void in
//            make.top.equalTo(viewContain.snp_top).offset(10)
            make.left.equalTo(txtviewAddCmt.snp_right)
            make.centerY.equalTo(txtviewAddCmt)
            make.width.equalTo(CGFloat(50))
            make.height.equalTo(CGFloat(50))
        }
    }
    
    func setLayer(){
        viewContain.layer.cornerRadius = 3
        viewContain.layer.borderColor = UIColor.gray.cgColor
        viewContain.layer.borderWidth = 1
        //viewContain.dropShadow()
    }
}

extension FeedCommentViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        txtviewAddCmt.text = String()
        btnSendCmt.isEnabled = true
        btnSendCmt.tintColor = .blue
    }
}

extension FeedCommentViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
             return
          }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

extension FeedCommentViewController {
    func showMoreSheetComment() {
        let alert = UIAlertController(title: "More Action", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit")
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete")
            self.tableViewCmts.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Cancel")
            self.tableViewCmts.reloadData()
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
//    func setData(_ comment: [FeedComment]?){
//        commentArray = comment
//        tableViewCmts.reloadData()
//    }
}
