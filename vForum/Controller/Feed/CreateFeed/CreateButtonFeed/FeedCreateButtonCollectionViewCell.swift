//
//  FeedCreateButtonCollectionViewCell.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit
import SnapKit

class FeedCreateButtonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var viewDoc: UIView!
    @IBOutlet weak var viewNgang: UIView!
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
        viewDoc.snp.makeConstraints{ (make)->Void in
            make.centerX.equalTo(viewContain)
            make.centerY.equalTo(viewContain)
            make.height.equalTo(viewContain).multipliedBy(0.5)
            make.width.equalTo(CGFloat(1))
        }
        viewNgang.snp.makeConstraints{ (make)->Void in
            make.centerX.equalTo(viewContain)
            make.centerY.equalTo(viewContain)
            make.width.equalTo(viewContain).multipliedBy(0.5)
            make.height.equalTo(CGFloat(1))
        }
    }
    
    func setLayer(){
        viewContain.layer.borderColor = UIColor.gray.cgColor
        viewContain.layer.borderWidth = 1
        viewContain.layer.cornerRadius = 3
    }
}
