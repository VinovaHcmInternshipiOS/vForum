import Foundation
import UIKit

class TopicTitleCell: UITableViewCell {
    @IBOutlet weak var Title: UITextView!
    @IBOutlet weak var Subtitle: UILabel!
    
    private(set) var creator:String = "Unspecified"
    private(set) var datetime:String = "Unknown date"
    
    func setTitle(_ str: String) {
        Title.text = str
    }
    
    func getTitleLineCount()->Int {
        return Int(Title.contentSize.height / Title.font!.lineHeight)
    }
    
    func setCreator(_ str: String) {
        creator = "@\(str)"
        Subtitle.text = "\(creator) · \(datetime)"
    }
    
    func setDatetime(_ str: String) {
        datetime = str
        Subtitle.text = "\(creator) · \(datetime)"
    }
}
