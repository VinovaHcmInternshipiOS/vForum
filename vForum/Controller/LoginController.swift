import UIKit
import SnapKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    let off = UIDevice.current.userInterfaceIdiom == .pad ? 250: 50
    
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var MainView: UIView!
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!

    @IBAction func PressLogin(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Username.delegate = self
        Password.delegate = self
        
        Username.layer.cornerRadius = 10
        Password.layer.cornerRadius = 10
        LoginButton.layer.cornerRadius = 30
        
        Username.leftViewMode = .always
        Username.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        Password.leftViewMode = .always
        Password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        Logo.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(off+50)
            make.left.equalTo(MainView.snp_left)
            make.right.equalTo(MainView.snp_right)
            make.height.equalTo(CGFloat(120))
        }
        
        Username.snp.makeConstraints{ (make)->Void in
            make.left.equalTo(MainView.snp_left).offset(off)
            make.right.equalTo(MainView.snp_right).offset(-off)
            make.top.equalTo(Logo.snp_bottom).offset(60)
            make.height.equalTo(CGFloat(50))
        }
        Password.snp.makeConstraints{ (make)->Void in
            make.left.equalTo(MainView.snp_left).offset(off)
            make.right.equalTo(MainView.snp_right).offset(-off)
            make.top.equalTo(Username.snp_bottom).offset(20)
            make.height.equalTo(CGFloat(50))
        }
        LoginButton.snp.makeConstraints{ (make)->Void in
            make.bottom.equalToSuperview().offset(-off-50)
            make.left.equalTo(MainView.snp_left).offset(off+30)
            make.right.equalTo(MainView.snp_right).offset(-off-30)
            make.height.equalTo(CGFloat(60))
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Username.endEditing(true)
        Password.endEditing(true)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.Logo.snp.updateConstraints{ (make)->Void in
                make.height.equalTo(CGFloat(120))
            }
            self.Username.snp.updateConstraints{ (make)->Void in
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
            self.Username.snp.updateConstraints{ (make)->Void in
                make.top.equalTo(self.Logo.snp_bottom).offset(40)
            }
            self.MainView.layoutIfNeeded()
        })
        return true
    }
}

