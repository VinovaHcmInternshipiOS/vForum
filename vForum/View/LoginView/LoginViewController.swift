//
//  LoginViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/14/20.
//  Copyright © 2020 trucdongtxtv. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import GoogleDataTransport
import GoogleUtilities

class LoginViewController: UIViewController, LoginButtonDelegate, GIDSignInDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    @IBAction func LOGINFACEBOOK(_ sender: Any) {
        let loginManager = LoginManager()
        if let _ = AccessToken.current {
                loginManager.logOut()
        } else {
            loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
                print("login success")
                let token = result?.token?.tokenString
                let request = FBSDKCoreKit.GraphRequest(graphPath: "me", parameters: ["fields":"id, name, email"], tokenString: token, version: nil, httpMethod: .get)
                request.start(completionHandler: { connection, result, error in
                    print("\(String(describing: result))")
                })
                guard error == nil else {
                        // Error occurred
                    print(error!.localizedDescription)
                    return
                }
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
            }
        }
    }
    
    @IBAction func LOGINGOOGLE(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKCoreKit.GraphRequest(graphPath: "me", parameters: ["fields":"id, name, email"], tokenString: token, version: nil, httpMethod: .get)
        request.start(completionHandler: { connection, result, error in
            print("\(String(describing: result))")
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Google Sing In didSignInForUser")
        
        if let error = error {
          print(error.localizedDescription)
          return
        }
      }
          // Start Google OAuth2 Authentication
      func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        // Showing OAuth2 authentication window
        if let aController = viewController {
          present(aController, animated: true) {() -> Void in }
        }
      }
    
      // After Google OAuth2 authentication
      func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        // Close OAuth2 authentication window
        dismiss(animated: true) {() -> Void in }
      }
}
