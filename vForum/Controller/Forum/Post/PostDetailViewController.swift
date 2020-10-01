import UIKit
import SnapKit
import Alamofire
import SVProgressHUD

class PostDetailViewController: UIViewController {
    let cmtCell = UINib(nibName: "PostCmtTableViewCell", bundle: nil)

    private(set) var postData:[[String:String]] = []
    
    var flag = 0
    var cmtData:[[String:String]] = []
    var likeCount = 0
    var cmt : String? = nil
    var user = ""
    var descriptionText = ""
    var titleText = ""
    var mainViewHeight : Constraint?
    var tableViewheight : CGFloat = 0
    var descriptionHeight : CGFloat = 0
    var titleTextHeight : CGFloat = 0

    @IBOutlet weak var scrollMainView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var likeUImgView: UIImageView!
    @IBOutlet weak var countLikeLbl: UILabel!
    @IBOutlet weak var titlePostLbl: UILabel!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCmtTextField: UITextField!
    @IBOutlet weak var cmtBtn: UIButton!
    
    let def = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setUpItem()
        addGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController!.isNavigationBarHidden = false
    }
    
    func setData(title: String, description: String, username: String, likeCount: Int) {
        titleText = title
        descriptionText = description
        user = username
        self.likeCount = likeCount
    }
    @IBAction func cmtThisPost(_ sender: Any) {
        if let cmt = cmt {
            postData.append(["createdBy": user, "description": cmt])
            tableViewheight = 0
            caculateHeightText(tableView.bounds.size)
            tableView.reloadData()
            addCmtTextField.text = nil
            cmtBtn.isEnabled = false
            cmtBtn.titleLabel?.textColor = #colorLiteral(red: 0.727089107, green: 0.7231606245, blue: 0.8079829812, alpha: 1)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
            
            caculateHeightText(mainView.bounds.size)
//        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            caculateHeightText(mainView.bounds.size)
//        }
    }
    
    private func estimateHeight(_ text : String , size : CGSize , font : UIFont) -> CGFloat {
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        return estimateFrame.height
    }

    private func caculateHeightText(_ size : CGSize){
        var cmts = [["@timon","@Dominic","@curtis","@curtis"],["tôi nghĩ nó không thể sử dụng", """
     var htmlString = “<html><body> <b>  HTML in UILabel is here…. </b> </body></html>”
     var attrStr: NSAttributedString? = nil
     do {
     if let data = htmlString.data(using: .unicode) {
     attrStr = try NSAttributedString(data: data, options: [
     NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html.rawValue
     ], documentAttributes: nil)
     }
     } catch {
     }
     var yourLabel = UILabel()
     yourLabel.attributedText = attrStr
     bạn có thế thử như thế này
     ""","""
     let yourLabel: UILabel = UILabel()
     yourLabel.frame = CGRect(x: 50, y: 150, width: 200, height: 21)
     yourLabel.backgroundColor = UIColor.orange
     yourLabel.textColor = UIColor.black
     yourLabel.textAlignment = NSTextAlignment.center
     yourLabel.text = "test label"
     self.view.addSubview(yourLabel)
     tôi đã thử và đã thành công
     ""","""
     var htmlString = “<html><body> <b>  HTML in UILabel is here…. </b> </body></html>”
     var attrStr: NSAttributedString? = nil
     do {
     if let data = htmlString.data(using: .unicode) {
     attrStr = try NSAttributedString(data: data, options: [
     NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html.rawValue
     ], documentAttributes: nil)
     }
     } catch {
     }
     var yourLabel = UILabel()
     yourLabel.attributedText = attrStr
     bạn có thế thử như thế này
     """]]
    
        
        if flag <= postData.count - 1 {
    
            for text in postData {
                let contrainSpace : CGFloat = 10
                let heightText = estimateHeight(text["createdBy"] ?? "", size: size, font: UIFont(name: "Futura", size: 14)!)
                tableViewheight += heightText + contrainSpace
            }
            
            for text in postData {
                let contrainSpace : CGFloat = 15
                let heightText = estimateHeight(text["description"] ?? "", size: size, font: UIFont(name: "Futura", size: 14)!)
                tableViewheight += heightText + contrainSpace
            }
            
            let total = tableViewheight + descriptionHeight + titleTextHeight + 60
            mainViewHeight?.updateOffset(amount:total)
        }
    }
    
//MARK:- Add GestureRecognizer
    private func addGestureRecognizer(){
        let tapAvtGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgTapped(tapGestureRecognizer:)))
            likeUImgView.isUserInteractionEnabled = true
            likeUImgView.addGestureRecognizer(tapAvtGestureRecognizer)
        
        let tapTagGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tagTapper(tapGestureRecognizer:)))
            userLbl.isUserInteractionEnabled = true
            userLbl.addGestureRecognizer(tapTagGestureRecognizer)
    }
    
    @objc func imgTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if let tappedImage = tapGestureRecognizer.view as? UIImageView {
            if tappedImage.tag == 0 {
                tappedImage.image = UIImage(named: "like")
                likeCount += 1
                tappedImage.tag = 1
            } else {
                tappedImage.image = UIImage(named: "notlike")
                if likeCount >= 0 {
                    likeCount -= 1
                }
                tappedImage.tag = 0
            }
            countLikeLbl.text = String(likeCount)
        }
        
    }
    
    @objc func tagTapper(tapGestureRecognizer: UITapGestureRecognizer) {
        let infoVC = InfoViewController.loadFromNib()
        self.navigationController?.present(infoVC, animated: true, completion: nil)
    }
    
//MARK: - Setup Item
    
    private func setUpItem(){
        tableView.register(UINib(nibName: "PostCmtTableViewCell", bundle: nil), forCellReuseIdentifier: "cmtCell")
        
        titlePostLbl.text = titleText
        userLbl.text = user
        descriptionLbl.text = descriptionText
        countLikeLbl.text = String(likeCount)
        
        addCmtTextField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        cmtBtn.layer.cornerRadius = 8
        cmtBtn.layer.borderWidth = 1
        cmtBtn.layer.borderColor = #colorLiteral(red: 0.727089107, green: 0.7231606245, blue: 0.8079829812, alpha: 1)
        
        addCmtTextField.layer.cornerRadius = 8
        addCmtTextField.layer.borderWidth = 1
        addCmtTextField.layer.borderColor = #colorLiteral(red: 0.727089107, green: 0.7231606245, blue: 0.8079829812, alpha: 1)
        
        descriptionHeight = descriptionLbl.sizeThatFits(mainView.bounds.size).height
        titleTextHeight = estimateHeight(titlePostLbl.text ?? "", size: mainView.bounds.size , font: UIFont(name: "Futura", size: 21)!)
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: descriptionHeight + 10, width: UIScreen.main.bounds.width - 40, height: 2)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        descriptionLbl.layer.addSublayer(bottomLine)
        
        scrollMainView.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.top.equalTo(self.view).offset(0.0)
            make.bottom.equalTo(addCmtTextField.snp.top).offset(-1)
        }

        mainView.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(scrollMainView.snp_leading).offset(10)
            make.bottom.equalTo(scrollMainView.snp_bottom).offset(-1)
            make.trailing.equalTo(scrollMainView.snp_trailing).offset(0)
            make.top.equalTo(scrollMainView.snp_top).offset(1)
            make.width.equalTo(UIScreen.main.bounds.width * 0.961353)
            self.mainViewHeight = make.height.equalTo(700).constraint
        }
        
        likeUImgView.contentMode = .scaleAspectFill

        likeUImgView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(30)
            make.top.equalTo(20)
            make.leading.equalTo(10)
        }

        countLikeLbl.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(20)
            make.centerY.equalTo(likeUImgView.snp_centerY)
            make.leading.equalTo(likeUImgView.snp_trailing).offset(5)
        }

        titlePostLbl.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(titleTextHeight)
            make.top.equalTo(mainView.snp_top).offset(10)
            make.leading.equalTo(countLikeLbl.snp_trailing).offset(5)
            make.top.equalTo(likeUImgView.snp_top)
            make.trailing.equalTo(mainView.snp_trailing).offset(-10)
        }

        userLbl.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(20)
            make.leading.equalTo(titlePostLbl.snp_leading)
            make.top.equalTo(titlePostLbl.snp_bottom).offset(5)
            make.trailing.equalTo(userLbl.snp_trailing).offset(-10)

        }

        descriptionLbl.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(descriptionHeight)
            make.leading.equalTo(mainView.snp_leading).offset(10)
            make.trailing.equalTo(mainView.snp_trailing).offset(-10)
            make.top.equalTo(userLbl.snp_bottom).offset(10)
        }
        
        let listCmtsHeight = CGFloat(postData.count * 100)
        tableView.snp.makeConstraints{(make) -> Void in
            make.height.greaterThanOrEqualTo(listCmtsHeight)
            make.leading.equalTo(mainView.snp_leading).offset(0)
            make.trailing.equalTo(mainView.snp_trailing).offset(0)
            make.top.equalTo(descriptionLbl.snp_bottom).offset(10)
            make.bottom.equalTo(addCmtTextField.snp_top).offset(-5)
        }
        
        caculateHeightText(mainView.bounds.size)
        
        addCmtTextField.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(40)
            make.leading.equalTo(self.view.snp_leading).offset(10)
            make.trailing.equalTo(self.view.snp_trailing).offset(-10)
        }

        cmtBtn.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.leading.equalTo(self.view.snp_leading).offset(10)
            make.top.equalTo(addCmtTextField.snp.bottom).offset(10)
            make.trailing.equalTo(self.view.snp_trailing).offset(-10)
            make.bottom.equalTo(self.view.safeAreaInsets.bottom).offset(-20)
        }
    }

}
//MARK: - Setup TableView
extension PostDetailViewController :UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: - Setup number of Cmt
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cmtCell") as! PostCmtTableViewCell
        cell.cmtLbl.text = postData[indexPath.row]["description"]
        cell.userLbl.text = postData[indexPath.row]["createdBy"]
        cell.userLbl.sizeToFit()
        cell.userLbl.tag = indexPath.row
        let tapTagGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tagTapper(tapGestureRecognizer:)))
        cell.userLbl.isUserInteractionEnabled = true
        cell.userLbl.addGestureRecognizer(tapTagGestureRecognizer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        
    }
    
}

extension PostDetailViewController : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            if text != " " && text != "" {
                cmt = text
                cmtBtn.isEnabled = true
                cmtBtn.titleLabel?.textColor = #colorLiteral(red: 0.193901211, green: 0.4506326318, blue: 0.7345073819, alpha: 1)
            } else {
                cmt = nil
                cmtBtn.isEnabled = false
                cmtBtn.titleLabel?.textColor = #colorLiteral(red: 0.727089107, green: 0.7231606245, blue: 0.8079829812, alpha: 1)
            }
            
        }
    }
}

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
}

// MARK: - GET DATA

extension PostDetailViewController {
    func getData() {
        SVProgressHUD.show()
        let networkManager = NetworkManager.shared
        
        let url : String = "http://localhost:4000/v1/api/group/\(def.string(forKey: "groupId")!)/topic/\(def.string(forKey: "topicId")!)/post"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(String(describing: def.object(forKey: "accessToken")!))"
        ]
        
        networkManager.request(url, headers: headers).responseJSON(completionHandler: {respond in
            
            switch respond.result {
            case .success(let JSON):
                let parsed = JSON as! NSDictionary
                
                if parsed["result"] != nil {
                    let data = parsed["result"] as! Array<NSDictionary>
                    let result = data[0]["commentsPost"] as! Array<NSDictionary>
                    
                    self.postData = []
                    for x in result {
                        self.postData.append([
                            "createdBy": String(describing: x["createdBy"]!),
                            "description": String(describing: x["description"]!)
                        ])
                    }
                    
                    self.tableView.reloadData()
                }
                SVProgressHUD.dismiss()
                
                
            case .failure( _):
                print("f")
            }
        })
    }
}

