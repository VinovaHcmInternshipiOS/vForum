//
//  SettingTableViewCell.swift
//  UiForum
//
//  Created by vinova on 25/09/2020.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var optionalLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
