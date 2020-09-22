import Foundation
import UIKit

class AppController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UINavigationController()
        let forumVc = ForumController(nibName: "ForumView", bundle: nil)
        
        vc.tabBarItem = UITabBarItem(title: "vForum", image: nil, tag: 0)
        vc.viewControllers = [forumVc]
        forumVc.title = "Groups"
        
        self.viewControllers = [vc]
    }
    
    
}
