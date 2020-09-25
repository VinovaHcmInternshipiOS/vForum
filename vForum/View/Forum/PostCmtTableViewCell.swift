//
//  PostCmtTableViewCell.swift
//  UiForum
//
//  Created by vinova on 22/09/2020.
//

import UIKit
import SnapKit
class PostCmtTableViewCell: UITableViewCell {

    @IBOutlet weak var userOutlet: UILabel!
    @IBOutlet weak var cmtOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpContraints()
    }

    private func setUpContraints(){
        userOutlet.snp.makeConstraints{(make) -> Void in
            make.top.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
        
        cmtOutlet.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(10)
            make.top.equalTo(userOutlet.snp_bottom).offset(5)
            make.bottom.trailing.equalTo(-10)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
