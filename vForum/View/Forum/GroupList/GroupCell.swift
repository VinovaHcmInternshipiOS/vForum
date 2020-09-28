import Foundation
import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var GroupLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var Background: UIImageView!
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var BlurLayer: UIView!
    
    @IBOutlet weak var CellEffect: UIImageView!
    @IBOutlet weak var SelectBackground: UIView!
    
    var groupId:String = ""
    
    func initCell() {
        CellView.layer.cornerRadius = 15
        CellView.clipsToBounds = true
        
        Avatar.layer.cornerRadius = Avatar.frame.width / 2
        BlurLayer.layer.compositingFilter = "overlayBlendMode"
        
        SelectBackground.isHidden = true
        selectionStyle = .none
    }

    func setTitle(_ str: String) {
        GroupLabel.text = str
    }
    
    func setTime(_ str: String) {
        let date = convertToDateTime(str)
        let dateInterval = Int(Date().timeIntervalSince(date))
        
        if dateInterval < 60 {
            TimeLabel.text = "Created \(dateInterval) seconds ago"
        }
        else if dateInterval < 60*60 {
            TimeLabel.text = "Created \(Int(dateInterval/60)) minutes ago"
        }
        else if dateInterval < 60*60*24 {
            TimeLabel.text = "Created \(Int(dateInterval/60/60)) hours ago"
        }
        else if dateInterval < 60*60*24*30 {
            TimeLabel.text = "Created \(Int(dateInterval/60/60/24)) days ago"
        } else {
            let format = DateFormatter()
            format.dateFormat = "dd/MM/yyyy"
            TimeLabel.text = "Created at \(format.string(from: date))"
        }
    }
    
    func setId(_ str: String) {
        groupId = str
    }
    
    func convertToDateTime(_ str: String)->Date {
        let dateFormatter = ISO8601DateFormatter()
        let trimmedIsoString = str.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        let date = dateFormatter.date(from: trimmedIsoString)!
        
        return date
    }

}
