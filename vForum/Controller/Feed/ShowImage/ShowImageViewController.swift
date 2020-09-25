//
//  ShowImageViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "AppIcon")
        imageView.snp.makeConstraints{ (make)->Void in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(imageView.snp_width)
        }
    }
    
    func setImage(_ image: UIImage){
        //imageView.image = image
    }
}
