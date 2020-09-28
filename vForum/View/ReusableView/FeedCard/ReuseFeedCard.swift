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
    var clickLike: (()->Void)? = nil
    var scrollAction: (()->Void)? = nil
    var commentAction: (()->Void)? = nil
    var toZoomScene: (()->Void)? = nil
    var liked = true
    var index = 0
    var likeCount = 0
    var commentCount = 0
    var color = [UIColor.red, UIColor.green, UIColor.yellow]
    @IBAction func LIKEFEED(_ sender: Any) {
        clickLike?()
    }
    @IBAction func COMMENTFEED(_ sender: Any) {
        commentAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setConstraint()
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setConstraint()
        setUpView()
    }
    
    func setUpView() {
        if liked {
            imageLiked.setImage(UIImage(named: "like"), for: .normal)
        }
        else {
            imageLiked.setImage(UIImage(named: "notlike"), for: .normal)
        }
        collectionviewImage.dataSource = self
        collectionviewImage.delegate = self
        pageControll.currentPage = index
        collectionviewImage.scrollToItem(at: IndexPath(item: index, section: 0), at: .right, animated: false)
        collectionviewImage.register(UINib(nibName: "ImageFeedCell", bundle: nil), forCellWithReuseIdentifier: "ImageFeedCell")
        lblLikeCount.text = "\(likeCount) like"
        lblCommentCount.text = "\(commentCount) comment"
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
}


extension ReuseFeedCard : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageFeedCell", for: indexPath) as? ImageFeedCell {
            cell.backgroundColor = color[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toZoomScene?()
    }
}

extension ReuseFeedCard : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0001
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0001
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionviewImage.visibleCells {
            if let indexPath = collectionviewImage.indexPath(for: cell) {
                index = indexPath.row
                pageControll.currentPage = index
                scrollAction?()
            }
        }
    }
}

extension ReuseFeedCard {
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

extension ReuseFeedCard {
    func setLikeCount(_ state: Bool){
        likeCount = state ?  (likeCount > 0 ? likeCount - 1: likeCount) : likeCount + 1
        lblLikeCount.text = likeCount > 1 ? "\(likeCount) likes" : "\(likeCount) like"
    }
    
    func setCommentCount() {
        //TODO:
    }
}
