//
//  ReuseFeedComment.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
class ReuseFeedComment: UIView {
    @IBOutlet weak var imageAva: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    var contentView:UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setConstraint()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setConstraint()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ReuseFeedComment", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setConstraint() {
        imageAva.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(CGFloat(50))
            make.height.equalTo(CGFloat(50))
        }
        lblUsername.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(imageAva.snp_right).offset(20)
        }
        lblTime.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(lblUsername.snp_right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        lblContent.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(lblUsername.snp_bottom).offset(10)
            make.left.equalTo(lblUsername.snp_left)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(10)
        }
    }

}
