//
//  FeedCreateViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

class FeedCreateViewController: UIViewController {

    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var collectionViewAttchment: UICollectionView!
    @IBOutlet weak var txtViewContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewAttchment.delegate = self
        collectionViewAttchment.dataSource = self
        collectionViewAttchment.register(UINib(nibName: "FeedCreateButtonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedCreateButtonCollectionViewCell")
        collectionViewAttchment.register(UINib(nibName: "FeedLoadImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedLoadImageCollectionViewCell")
        self.navigationItem.title = "Create"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 20)!]
        if #available(iOS 13.0, *) {
            let btnCreate = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CREATEDONE))
            self.navigationItem.rightBarButtonItem  = btnCreate
        } else {
            // Fallback on earlier versions
        }
        setContraints()
        setLayer()
    }
}

extension FeedCreateViewController: UICollectionViewDelegate {
}

extension FeedCreateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO:
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionViewAttchment.dequeueReusableCell(withReuseIdentifier: "FeedCreateButtonCollectionViewCell", for: indexPath) as! FeedCreateButtonCollectionViewCell
            return cell
        } else {
            let cell = collectionViewAttchment.dequeueReusableCell(withReuseIdentifier: "FeedLoadImageCollectionViewCell", for: indexPath) as! FeedLoadImageCollectionViewCell
            return cell
        }
    }
}

extension FeedCreateViewController {
    @objc func CREATEDONE(sender: UIBarButtonItem) {
        //TODO:
        self.navigationController?.pushViewController(FeedCreateViewController(), animated: true)
    }
    
    func setContraints(){
        viewContain.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalToSuperview()
        }
        txtViewContent.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(viewContain).offset(50)
            make.right.equalTo(viewContain).offset(-20)
            make.left.equalTo(viewContain).offset(20)
            make.height.equalTo(viewContain).multipliedBy(0.5)
        }
        collectionViewAttchment.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(txtViewContent.snp_bottom).offset(20)
            make.left.equalTo(txtViewContent)
            make.right.equalTo(txtViewContent)
            make.height.equalTo(txtViewContent).multipliedBy(0.3)
        }
    }
    
    func setLayer(){
        txtViewContent.layer.borderColor = UIColor.gray.cgColor
        txtViewContent.layer.borderWidth = 2
        txtViewContent.layer.cornerRadius = 3
    }
}
