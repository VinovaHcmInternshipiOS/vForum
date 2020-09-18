import Foundation
import UIKit
import SnapKit

class SignUpController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var JoinLabel: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var SignUpForm: UICollectionView!
    @IBOutlet weak var CreateButton: UIButton!
    @IBOutlet weak var alreadyHaveButton: UIButton!
    
    @IBAction func goBack() {
        navigationController!.popViewController(animated: true)
    }
    
    var fields: [SignUpField] = []
    var fieldTitles: [String] = ["Username","Display name","Email","Password","Re-enter your password"]
    var fieldsRequired: [Bool] = [true, false, true, true, true]
    
    let usernameFieldTag = 0
    let passwordFieldTag = [3,4]
    
    let width = UIDevice.current.userInterfaceIdiom == .pad ? 550: 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignUpForm.register(UINib(nibName: "SignUpFieldView", bundle: nil), forCellWithReuseIdentifier: "SignUpField")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        SignUpForm.delegate = self
        SignUpForm.dataSource = self
        
        CreateButton.layer.cornerRadius = CGFloat(25)
        
        setConstraints()
    }
    
    func setConstraints() {
        JoinLabel.snp.makeConstraints{ (make)->Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        SignUpForm.snp.makeConstraints{ (make)->Void in
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloat(400))
            make.top.equalTo(JoinLabel.snp_bottom).offset(30)
            make.height.equalTo(CGFloat(500))
        }
        
        BackButton.snp.makeConstraints{ (make)->Void in
            make.left.equalTo(SignUpForm).offset(20)
            make.top.equalTo(JoinLabel).offset(-5)
            make.width.equalTo(CGFloat(40))
            make.height.equalTo(CGFloat(42))
        }
        CreateButton.snp.makeConstraints{ (make)->Void in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
            make.width.equalTo(CGFloat(250))
            make.height.equalTo(CGFloat(50))
        }
        alreadyHaveButton.snp.makeConstraints{ (make)->Void in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalTo(CGFloat(250))
            make.height.equalTo(CGFloat(15))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fieldTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let field = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpField", for: indexPath) as! SignUpField

        let tag = indexPath.row
        
        field.TextField.delegate = self
        field.TextField.tag = tag
        field.TextField.isEnabled = true
        
        field.contentView.isUserInteractionEnabled = false
        
        field.TextField.isSecureTextEntry = passwordFieldTag.contains(tag)
        
        field.Label.text! = fieldTitles[tag]
        field.required = fieldsRequired[tag]
        
        field.RequiredFieldLabel.alpha = 0
        
        fields.append(field)
        
        return field
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let row = textField.tag
        if row < 4 {
            fields[row+1].TextField.becomeFirstResponder()
            return false
        }
        else {
            textField.endEditing(true)
            for x in 0..<fieldTitles.count {
                resetIndicator(x)
            }
        }
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let row = textField.tag
        fields[row].RequiredFieldLabel.alpha = 0
        fields[row].Underline.backgroundColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let row = textField.tag
        resetIndicator(row)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let row = textField.tag
        guard row != 0 && row != 2 else {
            if string == " " {
                return false
            }
            return true
        }
        guard row == 4 else {
            return true
        }
        let pass = fields[3].TextField.text!
        let retype = fields[4].TextField.text! + string
        
        if pass != retype {
            fields[4].RequiredFieldLabel.text! = "Incorrect password     "
            fields[4].RequiredFieldLabel.alpha = 1
            fields[4].Underline.backgroundColor = UIColor.systemRed
        } else {
            fields[row].RequiredFieldLabel.alpha = 0
            fields[row].Underline.backgroundColor = UIColor(red: 0.86, green: 0.85, blue: 0.93, alpha: 1.00)
        }
        
        return true
    }
    
    private func resetIndicator(_ row: Int) {
        if fields[row].TextField.text! == "" && fields[row].required {
            fields[row].RequiredFieldLabel.text! = "Required field"
            fields[row].RequiredFieldLabel.alpha = 1
            fields[row].Underline.backgroundColor = UIColor.systemRed
        }
        
        else if row == usernameFieldTag { // needs fix
            if isUsernameExist(fields[row].TextField.text!) {
                fields[row].RequiredFieldLabel.alpha = 1
                fields[row].Underline.backgroundColor = UIColor.systemRed
                fields[row].RequiredFieldLabel.text! = "Username is taken"
            } else {
                fields[row].RequiredFieldLabel.alpha = 0
                fields[row].Underline.backgroundColor = UIColor(red: 0.86, green: 0.85, blue: 0.93, alpha: 1.00)
            }
        }
            
        else if row == 4 { // needs fix
            if fields[3].TextField.text! != fields[4].TextField.text! {
                fields[4].RequiredFieldLabel.text! = "Incorrect password"
                fields[4].RequiredFieldLabel.alpha = 1
                fields[4].Underline.backgroundColor = UIColor.systemRed
            } else {
                fields[row].RequiredFieldLabel.alpha = 0
                fields[row].Underline.backgroundColor = UIColor(red: 0.86, green: 0.85, blue: 0.93, alpha: 1.00)
            }
        }
        else {
            fields[row].Underline.backgroundColor = UIColor(red: 0.86, green: 0.85, blue: 0.93, alpha: 1.00)
        }
    }
    
    @objc func keyboardAppear(notification: NSNotification) {
        SignUpForm.snp.updateConstraints{ (make)->Void in
            make.height.equalTo(CGFloat(UIScreen.main.bounds.height-460))
        }
        CreateButton.snp.updateConstraints{ (make)->Void in
            make.bottom.equalToSuperview().offset(-290)
        }
    }

    @objc func keyboardHide(notification: NSNotification) {
        SignUpForm.snp.updateConstraints{ (make)->Void in
            make.height.equalTo(CGFloat(500))
        }
        CreateButton.snp.updateConstraints{ (make)->Void in
            make.bottom.equalToSuperview().offset(-60)
        }
     }
}

// PLACEHOLDER
extension SignUpController {
    func isUsernameExist(_ str: String)->Bool {
        return false
    }
}
