import Foundation
import UIKit

class AppController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let forumVc = UINavigationController()
        let forumMainVc = ForumController(nibName: "ForumView", bundle: nil)
        
        
        forumVc.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        forumVc.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        
        
        forumVc.viewControllers = [forumMainVc]
        forumVc.tabBarItem.image = UIImage(named: "home")
        forumVc.tabBarItem.selectedImage = UIImage(named: "home")
        
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00)
        
        self.viewControllers = [forumVc]
    }
    
    
}
