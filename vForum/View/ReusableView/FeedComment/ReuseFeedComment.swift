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
    @IBOutlet weak var lblLikeComment: UILabel!
    @IBOutlet weak var imageAva: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var LIKECOMMENT: UIButton!
    @IBOutlet weak var lblCommentLikeCount: UILabel!
    var likeComment: (()->Void)? = nil
    var moreAction: (()->Void)? = nil
    @IBOutlet weak var btnMore: UIButton!
    
    @IBAction func LIKECOMMENTACTION(_ sender: Any) {
        likeComment?()
    }
    @IBAction func MORE(_ sender: Any) {
        moreAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ReuseFeedComment", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
