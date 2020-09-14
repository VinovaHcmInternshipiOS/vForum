import UIKit
import SnapKit

class LoginController: UIViewController, UITextFieldDelegate {
    
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

    @IBAction func PressLogin(_ sender: UIButton) {
        let vc = AppController()
        navigationController!.pushViewController(vc, animated: false)
    }
    
    @IBAction func PressSignUp(_ sender: UIButton) {
        let vc = SignUpController(nibName: "SignUpView", bundle: nil)
        navigationController!.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Username.delegate = self
        Password.delegate = self
        
        UsernameFrame.layer.cornerRadius = 10
        PasswordFrame.layer.cornerRadius = 10
        
        LoginButton.layer.cornerRadius = 25
        SignUpButton.layer.cornerRadius = 25
        
        SignUpButton.layer.borderWidth = 2
        SignUpButton.layer.borderColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00).cgColor
        
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

