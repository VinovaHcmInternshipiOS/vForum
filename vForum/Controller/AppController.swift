import Foundation
import UIKit

class AppController: UITabBarController {
    
}

class ForumTab: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Forumiew", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ForumController")
        addChild(vc)
    }
}
class FeedTab: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
class EventTab: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
class NotificationTab: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
