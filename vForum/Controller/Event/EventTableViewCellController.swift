//
//  EventTableViewCellController.swift
//  vForum
//
//  Created by Phúc Lý on 9/30/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class EventTableViewCell: UITableViewCell {
    var container: UIView?
    var marginSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 10
    var title: UILabel?
    var dateTime: UILabel?

    var event: Event? {
        didSet {
            guard let event = event else {
                return
            }
            guard let container = container else {
                return
            }
            let _img = UIImage(named: event.banner)
            guard let image = _img else {
                return
            }
            
            container.backgroundColor = UIColor(patternImage: image)
            container.alpha = 0.2
            
            title?.text = event.title
            dateTime?.text =  "\(event.getDate(from: event.startDate, format: "dd-MM-yyyy")) - \(event.getDate(from: event.endDate, format: "dd-MM-yyyy"))"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white

        initializeContainer()
        initializeTitle("")
        initializeDateTime("")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
