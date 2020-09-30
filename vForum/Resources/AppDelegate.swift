import UIKit
import FBSDKCoreKit
import Firebase
import FirebaseCore
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
        
//        RemoteAPIProvider.testingMethod()
        let remoteProvider = RemoteAPIProvider(configuration: AppsevicesConfiguration.deverloper)
        remoteProvider.requestFreeJSON(target: GroupResult.group, accessToken: "", fullfill: { (data) in
            print(data)
            do {
                if let result = data["result"] {
                    let dataResult = try JSONSerialization.data(withJSONObject: result, options: .fragmentsAllowed)
                    let decodable = JSONDecoder()
                    decodable.keyDecodingStrategy = .useDefaultKeys
                    decodable.dateDecodingStrategy = .millisecondsSince1970
                    
                    let list: [Group]? = try decodable.decode([Group].self, from: dataResult)
                    
                    print(list)
                }
            }
            catch let error {
                print(error)
            }
        }) { (err) in
            print(err.localizedDescription)
        }
//        remoteProvider.request(target: GroupResult.group, accessToken: "") { (returnData: [Group]?) in
//            print(returnData?.count)
//        } reject: { (Error) in
//            print(Error)
//        }

        
        return true
    }

    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        let handled = GIDSignIn.sharedInstance()?.handle(url) ?? false
        return handled
    }


}
