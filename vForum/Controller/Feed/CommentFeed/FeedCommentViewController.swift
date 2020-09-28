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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCmts.delegate = self
        tableViewCmts.dataSource = self
        tableViewCmts.register(UINib(nibName: "FeedCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedCommentTableViewCell")
        txtviewAddCmt.delegate = self
        self.navigationItem.title = "Comment"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 20)!]
        setConstraint()
        setLayer()
        btnSendCmt.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func ADDCOMMENT(_ sender: Any) {
        txtviewAddCmt.text = String()
        keyboardWillHide(notification: NSNotification(name: UIResponder.keyboardWillHideNotification, object: nil))
        view.endEditing(true)
    }
}

extension FeedCommentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
}

extension FeedCommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCommentTableViewCell") as? FeedCommentTableViewCell {
            return cell
        } else { return UITableViewCell()}
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

