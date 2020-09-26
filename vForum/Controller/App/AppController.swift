import Foundation
import UIKit

class AppController: UITabBarController {
    private(set) var username: String = ""
    private(set) var userId: String = ""

    init(username: String, userId: String) {
        self.username = username
        self.userId = userId
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let forumVc = UINavigationController()
        let forumMainVc = ForumController(nibName: "ForumView", bundle: nil)
        
        forumVc.viewControllers = [forumMainVc]
        
        forumVc.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        forumVc.tabBarItem.image = UIImage(named: "home")
        forumVc.tabBarItem.selectedImage = UIImage(named: "home")
        forumVc.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        
        
        let settingsVc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        settingsVc.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        settingsVc.tabBarItem.image = UIImage(named: "set")
        settingsVc.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        settingsVc.tabBarItem.selectedImage = UIImage(named: "set")
        
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00)
        
        
        self.viewControllers = [forumVc, settingsVc]
    }
    
    
}
