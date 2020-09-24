//
//  FeedDetailTableViewCell.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/23/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

class FeedDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var reuseComment: ReuseFeedComment!
    override func awakeFromNib() {
        super.awakeFromNib()
        setConstraints()
    }
    
    func setConstraints(){
        reuseComment.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
