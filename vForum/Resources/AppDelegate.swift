import UIKit
import FBSDKCoreKit
import Firebase
import GoogleSignIn
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let firstVc = LoginController(nibName: "LoginView", bundle: nil)
        let rootVc = UINavigationController(rootViewController: firstVc)
        rootVc.isNavigationBarHidden = true
        
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()
        
        RemoteAPIProvider.testingMethod()
        return true
    }

    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        let handled = GIDSignIn.sharedInstance()?.handle(url) ?? false
        return handled
    }


}
