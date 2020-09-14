import Foundation
import UIKit

class AppController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = ForumController(nibName: "ForumView", bundle: nil)
        vc.tabBarItem = UITabBarItem(title: "vForum", image: nil, tag: 0)
        
        self.viewControllers = [vc]
    }
}
