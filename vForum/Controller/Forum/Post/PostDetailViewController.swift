import UIKit
import SnapKit
import Alamofire

class PostDetailViewController: UIViewController {
    
    let cmtCell = UINib(nibName: "PostCmtTableViewCell", bundle: nil)
    let cmts = ["cmt":1,"cmt2":2,"cmt3":1,"cmt4":2,"cmt5":1,"cmt6":2,"cmt7":1,"cmt8":2,"cmt9":2,"cmt10":2,"cmt11":2,"cmt12":2,"cmt13":1,"cmt14":2,"cmt15":1,"cmt16":2,"cmt17":1,"cmt18":2,"cmt19":2]
    
    var cmtData:[[String:String]] = []
    
    @IBOutlet weak var scrollMainView: UIScrollView!
    @IBOutlet weak var mainViewOutlet: UIView!
    @IBOutlet weak var likeImgOutlet: UIImageView!
    @IBOutlet weak var likeCountOutlet: UILabel!
    @IBOutlet weak var titlePostOutlet: UILabel!
    @IBOutlet weak var userOutlet: UILabel!
    @IBOutlet weak var descriptionOutlet: UILabel!
    @IBOutlet weak var listCmtOutlet: UITableView!
    @IBOutlet weak var addCmtOutlet: UITextField!
    @IBOutlet weak var cmtBtnOutlet: UIButton!
    
    let def = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlePostOutlet?.text = "23432"
        
        /*let networkManager = NetworkManager.shared
        
        let url : String = "http://localhost:4000/v1/api/group/\(self.def.string(forKey: "groupId")!)/topic/\(self.def.string(forKey: "topicId")!)/post/\(self.def.string(forKey: "postId")!)/comment"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(String(describing: self.def.object(forKey: "accessToken")!))"
        ]
        
        networkManager.request(url, parameters: [:], headers: headers).responseJSON(completionHandler: {respond in
            
            switch respond.result {
            case .success(let JSON):
                let parsed = JSON as! NSDictionary
                
                if parsed["result"] != nil {
                    let res = parsed["result"] as! Array<NSDictionary>
                    print(res)
                }
                
            case .failure( _):
                return
            }
        })*/
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgTapped(tapGestureRecognizer:)))
        likeImgOutlet.isUserInteractionEnabled = true
        likeImgOutlet.addGestureRecognizer(tapGestureRecognizer)
        setUpItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController!.isNavigationBarHidden = false
    }
    
    func setData(title: String, description: String, username: String, likeCount: String) {
        //titlePostOutlet?.text = "23432"
    }
    
    @objc func imgTapped(tapGestureRecognizer: UITapGestureRecognizer){
      let tappedImage = tapGestureRecognizer.view as! UIImageView
      if tappedImage.tag == 0 {
        tappedImage.image = UIImage(named: "like")
        tappedImage.tag = 1
      } else {
        tappedImage.image = UIImage(named: "notlike")
        tappedImage.tag = 0
      }
    }
    
//MARK: - Setup item 
    
    private func setUpItem(){
        
        listCmtOutlet.register(cmtCell, forCellReuseIdentifier: "cmtCell")
        listCmtOutlet.delegate = self
        listCmtOutlet.dataSource = self
        listCmtOutlet.separatorStyle = .none
        listCmtOutlet.isScrollEnabled = false
        
        cmtBtnOutlet.layer.cornerRadius = 8
        cmtBtnOutlet.layer.borderWidth = 1
        cmtBtnOutlet.layer.borderColor = #colorLiteral(red: 0.727089107, green: 0.7231606245, blue: 0.8079829812, alpha: 1)
        
        addCmtOutlet.layer.cornerRadius = 8
        addCmtOutlet.layer.borderWidth = 1
        addCmtOutlet.layer.borderColor = #colorLiteral(red: 0.727089107, green: 0.7231606245, blue: 0.8079829812, alpha: 1)
        
        let heightDescription = descriptionOutlet.sizeThatFits(mainViewOutlet.frame.size).height
        let heightListCmts = CGFloat(cmts.count * 88)
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: heightDescription + 5, width: descriptionOutlet.sizeThatFits(mainViewOutlet.frame.size).width - 18, height: 2)
        
        bottomLine.backgroundColor = UIColor.black.cgColor
        descriptionOutlet.layer.addSublayer(bottomLine)
        scrollMainView.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.top.equalTo(self.view).offset(0.0)
            make.bottom.equalTo(addCmtOutlet.snp.top).offset(-10)
        }

        mainViewOutlet.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(scrollMainView.snp_leading).offset(10)
            make.bottom.equalTo(scrollMainView.snp_bottom).offset(-1)
            make.trailing.equalTo(scrollMainView.snp_trailing).offset(-1)
            make.top.equalTo(scrollMainView.snp_top).offset(1)
            make.width.equalTo(self.view.frame.width * 0.961353)
            make.height.equalTo( heightDescription + heightListCmts)
        }

        likeImgOutlet.contentMode = .scaleAspectFill

        likeImgOutlet.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(30)
            make.top.equalTo(20)
            make.leading.equalTo(10)
        }

        likeCountOutlet.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(30)
            make.centerY.equalTo(likeImgOutlet.snp_centerY)
            make.leading.equalTo(likeImgOutlet.snp_trailing).offset(5)
        }

        titlePostOutlet.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(20)
            make.leading.equalTo(likeCountOutlet.snp_trailing).offset(10)
            make.centerY.equalTo(likeImgOutlet.snp_centerY)
            make.trailing.equalTo(titlePostOutlet.snp_trailing).offset(-10)
        }

        userOutlet.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(20)
            make.leading.equalTo(titlePostOutlet.snp_leading)
            make.top.equalTo(titlePostOutlet.snp_bottom).offset(5)
            make.trailing.equalTo(userOutlet.snp_trailing).offset(-10)

        }

        descriptionOutlet.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(heightDescription)
            make.leading.equalTo(mainViewOutlet.snp_leading).offset(10)
            make.trailing.equalTo(mainViewOutlet.snp_trailing).offset(-10)
            make.top.equalTo(userOutlet.snp_bottom).offset(10)
        }

        listCmtOutlet.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(heightListCmts)
            make.leading.equalTo(mainViewOutlet.snp_leading).offset(0)
            make.trailing.equalTo(mainViewOutlet.snp_trailing).offset(-10)
            make.top.equalTo(descriptionOutlet.snp_bottom).offset(10)
            make.bottom.equalTo(addCmtOutlet.snp_top).offset(-5)
        }

        addCmtOutlet.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(40)
            make.leading.equalTo(self.view.snp_leading).offset(10)
            make.trailing.equalTo(self.view.snp_trailing).offset(-10)

        }

        cmtBtnOutlet.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.leading.equalTo(self.view.snp_leading).offset(10)
            make.top.equalTo(addCmtOutlet.snp.bottom).offset(10)
            make.trailing.equalTo(self.view.snp_trailing).offset(-10)
            make.bottom.equalTo(self.view.safeAreaInsets).offset(-20)
        }
    }

}
//MARK: - Setup listCmtTabeview
extension PostDetailViewController :UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: - Setup number of Cmt
        return cmts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cmtCell") as! PostCmtTableViewCell
        return cell
    }
    
    
}
