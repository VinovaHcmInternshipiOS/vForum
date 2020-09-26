import Foundation
import UIKit
import SnapKit

class PostPreviewCell: UITableViewCell {
    
    @IBOutlet weak var PostTitle: UITextView!
    @IBOutlet weak var Username: UILabel!
    
    @IBOutlet weak var Content: UITextView!
    @IBOutlet weak var ViewMoreComments: UIButton!
    
    var groupId:Int = -1
    
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
    func getCellHeight()->CGFloat {
        return CGFloat(getTitleLineCount()*30 + getContentLineCount()*20 + 30)
    }
}
