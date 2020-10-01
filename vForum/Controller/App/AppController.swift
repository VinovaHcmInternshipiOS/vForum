import Foundation
import UIKit

class AppController: UITabBarController {
    var accessToken = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpTabBar()
    }
    
    func setUpTabBar() {
        
        let forum = UINavigationController(rootViewController: ForumController(nibName: "ForumView", bundle: nil))
        forum.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        forum.tabBarItem.image = UIImage(named: "home")
        forum.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        forum.tabBarItem.selectedImage = UIImage(named: "home")
        
        let vcFeed = FeedHomeViewController(nibName: "FeedHomeViewController", bundle: nil)
        print(accessToken)
        //vcFeed.accessToken = accessToken
        let feed = UINavigationController(rootViewController: vcFeed)
        feed.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        feed.tabBarItem.image = UIImage(named: "feed")
        feed.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        feed.tabBarItem.selectedImage = UIImage(named: "feed")
        
        let event = UINavigationController(rootViewController: ListEventController())
        event.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        event.tabBarItem.image = UIImage(named: "event")
        event.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        event.tabBarItem.selectedImage = UIImage(named: "event")
        
        let notification = UINavigationController(rootViewController: NotificationViewController())
        notification.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        notification.tabBarItem.image = UIImage(named: "noti")
        notification.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        notification.tabBarItem.selectedImage = UIImage(named: "noti")
        
        let setting = UINavigationController(rootViewController: SettingViewController(nibName: "SettingViewController", bundle: nil))
        setting.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        setting.tabBarItem.image = UIImage(named: "set")
        setting.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        setting.tabBarItem.selectedImage = UIImage(named: "set")
        
        
        self.viewControllers = [forum, feed, event, notification, setting]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpTabBar()
    }
}
