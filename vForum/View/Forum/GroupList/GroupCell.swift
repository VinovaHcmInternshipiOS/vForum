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
    
    var groupId:Int = -1
    
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
        TimeLabel.text = str
    }
}
