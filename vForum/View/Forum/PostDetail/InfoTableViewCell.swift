//
//  InfoTableViewCell.swift
//  UiForum
//
//  Created by vinova on 30/09/2020.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpItem()
    }
    
    private func setUpItem(){
        let topLine = CALayer()
        topLine.frame = CGRect(x: 0, y: mainView.bounds.minY, width: UIScreen.main.bounds.width, height: 1)
        topLine.backgroundColor = UIColor.lightGray.cgColor
        mainView.layer.addSublayer(topLine)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
