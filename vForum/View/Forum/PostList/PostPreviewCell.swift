import Foundation
import UIKit
import SnapKit

class PostPreviewCell: UITableViewCell {
    
    @IBOutlet weak var PostTitle: UITextView!
    @IBOutlet weak var Username: UILabel!
    
    @IBOutlet weak var Content: UITextView!
    @IBOutlet weak var ViewMoreComments: UIButton!

    @IBOutlet weak var DateTime: UILabel!
    @IBOutlet weak var LikeButton: UIButton!
    
    private(set) var postId:String = ""

    @IBAction func like(_ str: String) {
        // MARK: -- GET LIKE FROM SERVER
        let isLiked = false

        switch isLiked {
            case true:
                LikeButton.backgroundImage = UIImage(named: "notlike")
                // MARK: -- SEND UNLIKE TO SERVER
            default:
                LikeButton.backgroundImage = UIImage(named: "like") 
                // MARK: -- SEND LIKE TO SERVER
        }
    }
    
    init(postData: [String:String]) {
        postId = postData["postId"]

        setTitle(postData["title"])
        setDateTime(postData["createdAt"])
        setContent(postData["description"])
    }

    func setTitle(_ str: String) {
        PostTitle.text = str
    }
    func getTitleLineCount()->Int {
        return Int(PostTitle.contentSize.height / PostTitle.font!.lineHeight)
    }
    
    func setContent(_ str: String) {
        Content.text = str
    }
    func getContentLineCount()->Int {
        return Int(Content.contentSize.height / Content.font!.lineHeight)
    }

    func setDateTime(_ str:String) {
        DateTime.text = str
    }
    func setCreator(_ str: String) {
        Username.text = str
    }

    func getCellHeight()->CGFloat {
        return CGFloat(getTitleLineCount()*30 + getContentLineCount()*20 + 30)
    }
}
