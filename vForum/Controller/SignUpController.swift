import Foundation
import UIKit
import SnapKit

class SignUpController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var JoinLabel: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var SignUpForm: UICollectionView!
    @IBOutlet weak var CreateButton: UIButton!
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController!.popViewController(animated: true)
    }
    
    var fields: [SignUpField] = []
    var fieldTitles: [String] = ["Username","Display name","Email","Password","Re-enter your password"]
    var fieldsRequired: [Bool] = [true, false, true, true, true]
    
    let passwordFieldTag = [3,4]
    let width = UIDevice.current.userInterfaceIdiom == .pad ? 550: 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        SignUpForm.delegate = self
        SignUpForm.dataSource = self
        
        CreateButton.layer.cornerRadius = CGFloat(25)
        
        JoinLabel.snp.makeConstraints{ (make)->Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(width-335)
        }
        
        SignUpForm.snp.makeConstraints{ (make)->Void in
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloat(400))
            make.top.equalTo(JoinLabel.snp_bottom).offset(25)
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
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(CGFloat(250))
            make.height.equalTo(CGFloat(50))
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
        field.TextField.isSecureTextEntry = passwordFieldTag.contains(tag)
        
        field.Label.text! = fieldTitles[tag]
        field.required = fieldsRequired[tag]
        
        field.RequiredFieldLabel.alpha = 0
        
        fields.append(field)
        
        return field
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        let row = textField.tag
        fields[row].Underline.backgroundColor = UIColor(red: 0.86, green: 0.85, blue: 0.93, alpha: 1.00)
        
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
        if fields[row].TextField.text! == "" && fields[row].required {
            fields[row].RequiredFieldLabel.alpha = 1
            fields[row].Underline.backgroundColor = UIColor.systemRed
        }
        else {
            fields[row].Underline.backgroundColor = UIColor(red: 0.86, green: 0.85, blue: 0.93, alpha: 1.00)
        }
        return true
    }
    
    @objc func keyboardAppear(notification: NSNotification) {
        SignUpForm.snp.updateConstraints{ (make)->Void in
            make.height.equalTo(CGFloat(UIScreen.main.bounds.height-405))
        }
    }

    @objc func keyboardHide(notification: NSNotification) {
        SignUpForm.snp.updateConstraints{ (make)->Void in
            make.height.equalTo(CGFloat(500))
        }
     }
}
