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
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblTimeCreate: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var collectionviewImage: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var imageLiked: UIButton!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var viewLine: UIView!
    @IBAction func LIKEFEED(_ sender: Any) {
    }
    @IBAction func COMMENTFEED(_ sender: Any) {
    }
    
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
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ReuseFeedCard", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setConstraint()  {
        imageAvatar.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(CGFloat(50))
            make.height.equalTo(CGFloat(50))
        }
        lblUsername.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10+50+30)
        }
        btnMore.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(10)
            make.width.equalTo(CGFloat(50))
            make.height.equalTo(CGFloat(50))
        }
        lblTimeCreate.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(lblUsername.snp_bottom).offset(5)
            make.left.equalTo(lblUsername.snp_left)
        }
        lblContent.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(imageAvatar.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(30)
        }
        collectionviewImage.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(lblContent.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(CGFloat(self.layer.frame.width))
        }
        pageControll.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(collectionviewImage.snp_bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        imageLiked.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(collectionviewImage.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(CGFloat(50))
            make.height.equalTo(CGFloat(50))
        }
        lblLikeCount.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(imageLiked.snp_bottom).offset(2)
            make.centerX.equalTo(imageLiked)
        }
        btnComment.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(collectionviewImage.snp_bottom).offset(10)
            make.right.equalToSuperview().offset(-50)
            make.width.equalTo(CGFloat(50))
            make.height.equalTo(CGFloat(50))
        }
        lblCommentCount.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(btnComment.snp_bottom).offset(2)
            make.centerX.equalTo(btnComment)
        }
        viewLine.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(lblLikeCount.snp_bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
