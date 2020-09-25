import Foundation
import UIKit

class TopicCell: UITableViewCell {
    @IBOutlet weak var MainView: UIView!
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Tick: UIImageView!
    
    @IBOutlet weak var LatestPost: UITextView!
    @IBOutlet weak var PostCount: UILabel!
}

extension TopicCell {
    func check() {
        Tick.layer.opacity = 1
    }
    
    func uncheck() {
        Tick.layer.opacity = 0
    }
    
    func setPostCount(_ count: Int) {
        guard count >= 1000 else {
            PostCount.text = String(count)
            return
        }
        
        let str = Array(String(count))
        if count < 10000 {
            PostCount.text = String(str[0]) + "." + String(str[1]) + "K"
        }
        else if count < 100000 {
            PostCount.text = String(str[0]) + String(str[1]) + "K"
        }
        else if count < 1000000 {
            PostCount.text = String(str[0]) + String(str[1]) + String(str[2]) + "K"
        }
    }
    
    func initCell() {
        backgroundColor = .clear
        MainView.layer.cornerRadius = 8
        
        PostCount.layer.cornerRadius = 22.5
        uncheck()
    }
    
    func setTitle(_ str: String) {
        Title.text = str
    }
    
    func setCreator(_ str: String) {
        Username.text = "@" + str
    }
}
