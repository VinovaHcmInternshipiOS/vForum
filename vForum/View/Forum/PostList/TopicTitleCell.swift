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
        let date = convertToDateTime(str)
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy, HH:mm"
        datetime = format.string(from: date)
        
        Subtitle.text = "\(creator) · \(datetime)"
    }
    
    func convertToDateTime(_ str: String)->Date {
        let dateFormatter = ISO8601DateFormatter()
        let trimmedIsoString = str.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        let date = dateFormatter.date(from: trimmedIsoString)!
        
        return date
    }
}
