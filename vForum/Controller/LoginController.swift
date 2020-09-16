import UIKit
import SnapKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import GoogleDataTransport
import GoogleUtilities

class LoginController: UIViewController, UITextFieldDelegate, GIDSignInDelegate {
    
    let off = UIDevice.current.userInterfaceIdiom == .pad ? 250: 50
    
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var MainView: UIView!
    
    @IBOutlet weak var UsernameFrame: UIView!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var UsernameIcon: UIImageView!
    
    @IBOutlet weak var PasswordFrame: UIView!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var PasswordIcon: UIImageView!
    
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var btnLoginFacebook: UIButton!
    @IBOutlet weak var btnLoginGg: UIButton!
    
    @IBAction func PressSignUp(_ sender: UIButton) {
        let vc = SignUpController(nibName: "SignUpView", bundle: nil)
        navigationController!.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
        
        Username.delegate = self
        Password.delegate = self
        
        setCornerRadius()
        setConstraints()
    }

    func setCornerRadius() {
        UsernameFrame.layer.cornerRadius = 10
        PasswordFrame.layer.cornerRadius = 10
        
        LoginButton.layer.cornerRadius = 25
        SignUpButton.layer.cornerRadius = 25
        
        SignUpButton.layer.borderWidth = 2
        SignUpButton.layer.borderColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00).cgColor
        
        btnLoginFacebook.layer.cornerRadius = 20
        btnLoginGg.layer.cornerRadius = 20
    }
    
    func setConstraints() {
        Logo.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(off+50)
            make.left.equalTo(MainView.snp_left)
            make.right.equalTo(MainView.snp_right)
            make.height.equalTo(CGFloat(120))
        }
        UsernameFrame.snp.makeConstraints{ (make)->Void in
            make.left.equalTo(MainView).offset(off)
            make.right.equalTo(MainView).offset(-off)
            make.top.equalTo(Logo.snp_bottom).offset(60)
            make.height.equalTo(CGFloat(50))
        }
        UsernameIcon.snp.makeConstraints{ (make)->Void in
            make.left.equalTo(UsernameFrame).offset(10)
            make.top.equalTo(UsernameFrame)
            make.bottom.equalTo(UsernameFrame)
            make.width.equalTo(CGFloat(25))
        }
        Username.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(UsernameFrame)
            make.bottom.equalTo(UsernameFrame)
            make.left.equalTo(UsernameIcon.snp_right).offset(10)
            make.right.equalTo(UsernameFrame)
        }
        PasswordIcon.snp.makeConstraints{ (make)->Void in
            make.left.equalTo(PasswordFrame).offset(10)
            make.top.equalTo(PasswordFrame)
            make.bottom.equalTo(PasswordFrame)
            make.width.equalTo(CGFloat(25))
        }
        PasswordFrame.snp.makeConstraints{ (make)->Void in
            make.left.equalTo(MainView).offset(off)
            make.right.equalTo(MainView).offset(-off)
            make.top.equalTo(UsernameFrame.snp_bottom).offset(15)
            make.height.equalTo(CGFloat(50))
        }
        Password.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(PasswordFrame)
            make.bottom.equalTo(PasswordFrame)
            make.left.equalTo(PasswordIcon.snp_right).offset(10)
            make.right.equalTo(PasswordFrame)
        }
        
        LoginButton.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(PasswordFrame.snp_bottom).offset(off-25)
            make.left.equalTo(MainView.snp_left).offset(off+30)
            make.right.equalTo(MainView.snp_right).offset(-off-30)
            make.height.equalTo(CGFloat(50))
        }
        SignUpButton.snp.makeConstraints{ (make)->Void in
            make.bottom.equalToSuperview().offset(-50)
            make.left.equalTo(MainView.snp_left).offset(off+30)
            make.right.equalTo(MainView.snp_right).offset(-off-30)
            make.height.equalTo(CGFloat(50))
        }
        btnLoginFacebook.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(LoginButton.snp_bottom).offset(off-30)
            make.left.equalTo(MainView.snp_left).offset(off+30)
            make.right.equalTo(MainView.snp_right).offset(-off-30)
            make.height.equalTo(CGFloat(40))
        }
        
        btnLoginGg.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(btnLoginFacebook.snp_bottom).offset(off-30)
            make.left.equalTo(MainView.snp_left).offset(off+30)
            make.right.equalTo(MainView.snp_right).offset(-off-30)
            make.height.equalTo(CGFloat(40))
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.Logo.snp.updateConstraints{ (make)->Void in
                make.height.equalTo(CGFloat(120))
            }
            self.UsernameFrame.snp.updateConstraints{ (make)->Void in
                make.top.equalTo(self.Logo.snp_bottom).offset(60)
            }
            self.MainView.layoutIfNeeded()
        })
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.5, animations: {
            self.Logo.snp.updateConstraints{ (make)->Void in
                make.height.equalTo(CGFloat(70))
            }
            self.UsernameFrame.snp.updateConstraints{ (make)->Void in
                make.top.equalTo(self.Logo.snp_bottom).offset(40)
            }
            self.MainView.layoutIfNeeded()
            textField.superview?.layer.borderWidth = 1
            textField.superview?.layer.borderColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00).cgColor
        })
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.5, animations: {
            textField.superview?.layer.borderWidth = 0
        })
        return true
    }
}






// PLACEHOLDER FUNCTIONS
extension LoginController {
    @IBAction func PressLogin(_ sender: UIButton) {
        let vc = AppController()
        navigationController!.pushViewController(vc, animated: false)
    }
}








/////////////////////////////////////////////////////////////
// FACEBOOK/GOOGLE
extension LoginController {
    @IBAction func LOGINFACEBOOK(_ sender: Any) {
        let loginManager = LoginManager()
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
            print(AccessToken.current?.tokenString ?? "Print fail")
            self?.navigationController?.pushViewController(AppController(), animated: true)
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
        print("Log out")
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Google Sing In didSignInForUser")
        if let error = error {
          print(error.localizedDescription)
          return
        }
        print("\(String(describing: user.profile.name)) \n")
        print("\(String(describing: user.profile.email)) \n")
        self.navigationController?.pushViewController(AppController(), animated: true)
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
