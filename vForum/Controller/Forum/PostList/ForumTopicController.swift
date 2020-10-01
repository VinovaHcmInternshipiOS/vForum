import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class ForumTopicController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var postList: UITableView!
    @IBOutlet weak var searchBar: UITextField!
    
    let def = UserDefaults.standard
    
    var topicTitleLineCount: Int = 0

    private(set) var postData:[[String:String]] = []
    private(set) var sortedPostData:[[String:String]] = []
    
    private(set) var topicTitle: String = ""
    private(set) var topicCreator: String = ""
    private(set) var topicDateTime: String = ""
    private(set) var topicId: String = ""
    
    private(set) var postCells: [PostPreviewCell] = []
    private(set) var postPrototypeCell: PostPreviewCell!
    
    //var deletePopupState:Int = 0
    //var goToNextView: Bool = true

    @IBAction func add(_ sender: UIButton) {
        let vc = AddViewController(nibName: "AddViewController", bundle: nil)
        navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func sort(_ sender: UIButton) {
        let choiceBox = UIAlertController(title: "Sort posts", message: "", preferredStyle: .actionSheet)
        // MARK: -- SORT
        choiceBox.addAction(UIAlertAction(title: "Newest first", style: .default, handler: { action in
                self.sortedPostData.sort {
                    (self.convertToDateTime($0["createdAt"]!) > self.convertToDateTime($1["createdAt"]!))
                }
                self.postList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Oldest first", style: .default, handler: { action in
                self.sortedPostData.sort {
                    (self.convertToDateTime($0["createdAt"]!) < self.convertToDateTime($1["createdAt"]!))
                }
                self.postList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Most likes", style: .default, handler: { action in
                self.sortedPostData.sort {
                    (Int($0["countLike"]!) ?? 0) > (Int($1["countLike"]!) ?? 0)
                }
                self.postList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(choiceBox, animated: true)
    }

    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        postList.rowHeight = UITableView.automaticDimension
        
        postList.register(UINib(nibName: "PostPreviewCellView", bundle: nil), forCellReuseIdentifier: "Post")
        postList.register(UINib(nibName: "TopicTitleCellView", bundle: nil), forCellReuseIdentifier: "TopicTitle")
        
        postPrototypeCell = (postList.dequeueReusableCell(withIdentifier: "Post") as! PostPreviewCell)
        
        navigationController?.navigationBar.isHidden = true
        
        postList.delegate = self
        postList.dataSource = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController!.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.isNavigationBarHidden = true
        
        postData = []
        sortedPostData = []
        getData()
    }
    
    func convertToDateTime(_ str: String)->Date {
        let dateFormatter = ISO8601DateFormatter()
        let trimmedIsoString = str.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        let date = dateFormatter.date(from: trimmedIsoString)!
        
        return date
    }

    func setTitle(_ str: String) {
        topicTitle = str
    }

    func setCreator(_ str: String) {
        topicCreator = str
    }
    
    func setDateTime(_ str: String) {
        topicDateTime = str
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPostData.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTitle", for: indexPath) as! TopicTitleCell

            cell.backgroundColor = UIColor.clear

            // MARK: -- ADD DATA
            

            cell.setTitle(topicTitle)
            topicTitleLineCount = cell.getTitleLineCount()
            cell.setCreator(topicCreator)
            cell.setDatetime(topicDateTime)
            
            cell.selectionStyle = .none
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! PostPreviewCell
            
            cell.setConstraints()
            
            cell.setTitle(sortedPostData[indexPath.row - 1]["title"]!)
            cell.setContent(sortedPostData[indexPath.row - 1]["description"]!)
            cell.setDateTime(sortedPostData[indexPath.row - 1]["createdAt"]!)
            cell.setCreator(sortedPostData[indexPath.row - 1]["createdBy"]!)
            cell.setLikeCount(sortedPostData[indexPath.row - 1]["countLike"]!)

            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return CGFloat(topicTitleLineCount * 30 + 60)
        default:
            postPrototypeCell.setTitle(sortedPostData[indexPath.row - 1]["title"]!)
            postPrototypeCell.setContent(sortedPostData[indexPath.row - 1]["description"]!)
            
            return postPrototypeCell.getCellHeight()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if goToNextView {
        let vc = PostDetailViewController(nibName: "PostDetailViewController", bundle: nil)
        vc.title = "Post"
        
        let data = postData[indexPath.row - 1]
        //print(data["title"]!)
        if let title = data["title"] , let description = data["description"] , let user = data["createdBy"], let countLike = data["countLike"] {
            vc.setData(title: title, description: description, username: "@" + user, likeCount: Int(countLike)!)
        }
        
        def.set(postData[indexPath.row - 1]["_id"], forKey: "postId")
        
        navigationController?.pushViewController(vc, animated: true)
        navigationController!.isNavigationBarHidden = false
        //}
    }
}




extension ForumTopicController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var str = textField.text!
        str = string.count == 0 ? String(str.dropLast()) : str + string
        
        if str == "" {
            sortedPostData = postData
        } else {
            sortedPostData = postData.filter{ $0["title"]!.lowercased().contains(str.lowercased()) }
        }
        
        postList.reloadData()
        
        return true
    }

    private func textFieldShouldReturn(_ textField: UITextField) {
        textField.endEditing(true)
    }
}




// MARK: - GET DATA

extension ForumTopicController {
    func getData() {
        SVProgressHUD.show()
        let networkManager = NetworkManager.shared
        
        let url : String = "http://localhost:4000/v1/api/group/\(def.string(forKey: "groupId")!)/topic/\(def.string(forKey: "topicId")!)/post"
        let parameter : [String : Any] = [:]
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(String(describing: def.object(forKey: "accessToken")!))"
        ]
        
        networkManager.request(url, parameters: parameter, headers: headers).responseJSON(completionHandler: {respond in
            
            switch respond.result {
            case .success(let JSON):
                let parsed = JSON as! NSDictionary
                
                if parsed["result"] != nil {
                    let result = parsed["result"] as! Array<NSDictionary>
                    
                    self.postData = []
                    for x in result {
                        self.postData.append([
                            "title": String(describing: x["title"]!),
                            "description": String(describing: x["description"]!),
                            "createdAt":String(describing: x["createdAt"]!),
                            "createdBy":String(describing: x["createdBy"]!),
                            "_id":String(describing: x["_id"]!),
                            "countLike":String(describing: x["countLike"]!)
                        ])
                    }
                    self.sortedPostData = self.postData
                    self.postList.reloadData()
                }
                SVProgressHUD.dismiss()
                
                
            case .failure( _):
                print("f")
            }
        })
    }
}








// DELETE POST
/*
extension ForumTopicController {
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self.deletePopupState = 0
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {}, completion: {action in
            self.deletePopupState += 1
            
            if self.deletePopupState == 1 {
                self.showDeletePopup(indexPath)
            }
        })
    }
    
    func showDeletePopup(_ indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete post", message: "Are you sure you want to delete this topic?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            self.goToNextView = true
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            let networkManager = NetworkManager.shared
            
            let url : String = "http://localhost:4000/v1/api/group/\(self.def.string(forKey: "groupId")!)/topic/\(self.def.string(forKey: "topicId")!)/post/\(String(describing: self.postData[indexPath.row]["_id"]!))"
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(String(describing: self.def.object(forKey: "accessToken")!))"
            ]
            
            networkManager.request(url, method: .delete, parameters: [:], headers: headers).responseJSON(completionHandler: {respond in
                
                switch respond.result {
                case .success(let JSON):
                    let parsed = JSON as! NSDictionary
                    
                    if parsed["result"] == nil {
                        let alert = UIAlertController(title: "Error!", message: String(describing: parsed["message"]!), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                    self.getData()
                    
                case .failure( _):
                    print("f")
                }
            })
            self.goToNextView = true
        }))
        self.present(alert, animated: true)
        self.goToNextView = false
    }
}
*/

