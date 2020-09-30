//
//  FeedLoadImageCollectionViewCell.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

class FeedLoadImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var imageUpload: UIImageView!
    @IBOutlet weak var btnDeleteImage: UIButton!
    @IBOutlet weak var DELETEIMAGE: UIButton!
    var deleteImage: (()->Void)? = nil
    @IBAction func DELETEIMAGE(_ sender: Any) {
        deleteImage?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setConstraints()
        setLayer()
    }
    
    func setConstraints(){
        viewContain.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview()
            //make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(viewContain.snp_height)
        }
        imageUpload.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(viewContain)
            make.right.equalTo(viewContain)
            make.left.equalTo(viewContain)
            make.bottom.equalTo(viewContain)
        }
    }
    
    func setLayer(){
        viewContain.layer.borderColor = UIColor.gray.cgColor
        viewContain.layer.borderWidth = 1
        viewContain.layer.cornerRadius = 3
    }
}
