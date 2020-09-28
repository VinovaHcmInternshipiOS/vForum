import Foundation
import UIKit
import SnapKit

class PostPreviewCell: UITableViewCell {
    
    @IBOutlet weak var PostTitle: UITextView!
    @IBOutlet weak var Username: UILabel!
    
    @IBOutlet weak var Content: UITextView!
    @IBOutlet weak var ViewMoreComments: UIButton!

    @IBOutlet weak var LikeCount: UILabel!
    
    @IBOutlet weak var DateTime: UILabel!
    @IBOutlet weak var LikeButton: UIButton!
    
    private(set) var postId:String = ""

    @IBAction func like() {
        // MARK: -- GET LIKE FROM SERVER
        let isLiked = false

        switch isLiked {
            case true:
                print("unlike")
                // MARK: -- SEND UNLIKE TO SERVER
            default:
                print("like")
                // MARK: -- SEND LIKE TO SERVER
        }
    }
    
    func setConstraints() {
        Username.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(PostTitle.snp_bottom)
            make.left.equalTo(PostTitle).offset(5)
        }
        
        DateTime.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(Username.snp_bottom)
            make.left.equalTo(Username)
        }
        
        Content.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(DateTime.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        ViewMoreComments.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(Content.snp_bottom).offset(7)
            make.centerX.equalToSuperview()
        }
    }
    
    func setData(postData: [String:String]) {
        postId = postData["postId"]!

        setTitle(postData["title"]!)
        setDateTime(postData["createdAt"]!)
        setContent(postData["description"]!)
    }

    func setTitle(_ str: String) {
        PostTitle.text = str
        let a = PostTitle.frame.width
        PostTitle.sizeToFit()
        
        PostTitle.layer.frame.size = CGSize(width: a, height: PostTitle.frame.height)
    }
    
    func getTitleLineCount()->Int {
        return Int(PostTitle.contentSize.height / PostTitle.font!.lineHeight)
    }
    
    func setContent(_ str: String) {
        Content.text = str
        let a = Content.frame.width
        Content.sizeToFit()
        
        Content.layer.frame.size = CGSize(width: a, height: Content.frame.height)
    }

    func getContentLineCount()->Int {
        return Int(Content.contentSize.height / Content.font!.lineHeight)
    }

    func setDateTime(_ str:String) {
        DateTime?.text = str
    }
    
    func setCreator(_ str: String) {
        Username.text = str
    }

    func setLikeCount(_ c: String) {
        if c.count <= 3 {
            LikeCount.text = c
            return
        }
        
        let str = Array(c)
        if c.count == 4 {
            LikeCount.text = String(str[0]) + "." + String(str[1]) + "K"
        }
        else if c.count == 5 {
            LikeCount.text = String(str[0]) + String(str[1]) + "K"
        }
        else if c.count == 6 {
            LikeCount.text = String(str[0]) + String(str[1]) + String(str[2]) + "K"
        }
    }

    func getCellHeight()->CGFloat {
        return CGFloat(Content.contentSize.height + PostTitle.contentSize.height + 120)
    }
}
