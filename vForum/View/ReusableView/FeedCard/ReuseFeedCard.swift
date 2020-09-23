//
//  ReuseFeedCard.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/21/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit

@IBDesignable
class ReuseFeedCard: UIView {
    var contentView:UIView?
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblTimeCreate: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var collectionviewImage: UICollectionView!
    @IBOutlet weak var imageLiked: UIButton!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBAction func LIKEFEED(_ sender: Any) {
    }
    @IBAction func COMMENTFEED(_ sender: Any) {
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
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ReuseFeedCard", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
