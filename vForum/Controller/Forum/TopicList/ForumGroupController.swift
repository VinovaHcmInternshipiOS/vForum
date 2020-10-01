import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class ForumGroupController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TopicList: UITableView!
    
    let def = UserDefaults.standard
    
    var topicData:[[String:String]] = []
    var sortedTopicData:[[String:String]] = []
    
    var deletePopupState:Int = 0
    var goToNextView: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        navigationController?.navigationBar.isTranslucent = false
        
        let role = def.string(forKey: "role")!
        
        let btn2 = UIButton(type: .system)
        btn2.setImage(UIImage(named: "sort"), for: .normal)
        btn2.tintColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00)
        
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(sortTopic), for: .touchUpInside)
        
        let item2 = UIBarButtonItem(customView: btn2)
        
        if role == "admin" || role == "moderator" {
            let btn1 = UIButton(type: .system)
            btn1.setImage(UIImage(named: "add"), for: .normal)
            btn1.tintColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00)
            
            btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn1.addTarget(self, action: #selector(addTopic), for: .touchUpInside)
            
            let item1 = UIBarButtonItem(customView: btn1)
            navigationItem.rightBarButtonItems = [item1, item2]
        } else {
            navigationItem.rightBarButtonItems = [item2]
        }

        TopicList.backgroundColor = .clear
        TopicList.register(UINib(nibName: "TopicCellView", bundle: nil), forCellReuseIdentifier: "TopicCell")
        
        TopicList.delegate = self
        TopicList.dataSource = self
    }
    
    
    // MARK: - ADD TOPIC
    @objc func addTopic() {
        let vc = AddViewController(nibName: "AddViewController", bundle: nil)
        vc.mode = "topic"
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - SORT TOPIC
    @objc func sortTopic() {
        let choiceBox = UIAlertController(title: "Sort topic", message: "", preferredStyle: .actionSheet)
        // MARK: -- SORT
        choiceBox.addAction(UIAlertAction(title: "Newest first", style: .default, handler: { action in
                self.sortedTopicData.sort {
                    (self.convertToDateTime($0["createdAt"]!) > self.convertToDateTime($1["createdAt"]!))
                }
                self.TopicList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Oldest first", style: .default, handler: { action in
                self.sortedTopicData.sort {
                    (self.convertToDateTime($0["createdAt"]!) < self.convertToDateTime($1["createdAt"]!))
                }
                self.TopicList.reloadData()
            })
        )
        /*choiceBox.addAction(UIAlertAction(title: "Most posts", style: .default, handler: { action in
                self.sortedTopicData.sort {
                    (Int($0["postCount"]!) ?? 0) > (Int($1["postCount"]!) ?? 0)
                }
                self.TopicList.reloadData()
            })
        )*/
        choiceBox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(choiceBox, animated: true)
    }
    
    func convertToDateTime(_ str: String)->Date {
        let dateFormatter = ISO8601DateFormatter()
        let trimmedIsoString = str.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        let date = dateFormatter.date(from: trimmedIsoString)!
        
        return date
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedTopicData.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
        
        cell.initCell()
            
        cell.setTitle(sortedTopicData[indexPath.row]["name"] ?? "")
        cell.setPostCount(Int(sortedTopicData[indexPath.row]["postCount"] ?? "") ?? 0)
        cell.setDescription(sortedTopicData[indexPath.row]["description"] ?? "")
        cell.setCreator(sortedTopicData[indexPath.row]["createdBy"] ?? "")
        cell.setDateTime(sortedTopicData[indexPath.row]["createdAt"] ?? "")

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if goToNextView {
            def.set(sortedTopicData[indexPath.row]["_id"], forKey: "topicId")
            
            let vc = ForumTopicController(nibName: "ForumTopicView", bundle: nil)
            vc.setTitle(sortedTopicData[indexPath.row]["name"] ?? "")
            vc.setCreator(sortedTopicData[indexPath.row]["createdBy"] ?? "")
            vc.setDateTime(sortedTopicData[indexPath.row]["createdAt"] ?? "")
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopicCell
        self.deletePopupState = 0
        
        cell.MainView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            cell.MainView.backgroundColor = UIColor(white: 0.8, alpha: 1)
        }, completion: {action in
            
            
            // MARK: - GET USER ID
            
            
            //guard self.def.string(forKey: "role")! == "admin" else {
            //    return
            //}
            self.deletePopupState += 1
            
            if self.deletePopupState == 1 {
                self.showDeletePopup(indexPath)
            }
        })
    }
    
    func showDeletePopup(_ indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete topic", message: "Are you sure you want to delete this topic?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            self.goToNextView = true
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            let networkManager = NetworkManager.shared
            SVProgressHUD.show()
            
            let url : String = "http://localhost:4000/v1/api/group/\(self.def.string(forKey: "groupId")!)/topic/\(String(describing: self.topicData[indexPath.row]["_id"]!))"
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(self.def.string(forKey: "accessToken")!)"
            ]
            
            networkManager.request(url, method: .delete, parameters: [:], headers: headers).responseJSON(completionHandler: {respond in
                
                switch respond.result {
                case .success(let JSON):
                    let parsed = JSON as! NSDictionary
                    print(parsed)

                    SVProgressHUD.dismiss()
                    
                    if String(describing: parsed["success"]!) == "0" {
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
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopicCell
        cell.MainView.backgroundColor = UIColor.white
        
        deletePopupState = -1
    }
    
}




// MARK: - GET DATA

extension ForumGroupController {
    func getData() {
        let networkManager = NetworkManager.shared
        
        let url : String = "http://localhost:4000/v1/api/group/\(def.string(forKey: "groupId")!)/topic"
        let parameter : [String : Any] = [:]
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(String(describing: def.object(forKey: "accessToken")!))"
        ]
        
        networkManager.request(url, parameters: parameter, headers: headers).responseJSON(completionHandler: {respond in
            
            switch respond.result {
            case .success(let JSON):
                let parsed = JSON as! NSDictionary
                
                if parsed["result"] != nil {
                    //print(parsed)
                    self.topicData = []
                    let result = parsed["result"] as! Array<NSDictionary>
                    
                    for x in result {
                        
                        /*
                        let topicUrl = "http://localhost:4000/v1/api/group/\(self.def.string(forKey: "groupId")!)/topic/\(String(describing: x["_id"]!))/post"
                        //print("adadadadadadada")
                        networkManager.request(topicUrl, parameters: [:], headers: headers).responseJSON(completionHandler: {respond in
                            
                            switch respond.result {
                            case .success(let JSON):
                                let parsed = JSON as! NSDictionary
                                
                                if parsed["result"] != nil {
                                    let res = parsed["result"] as! Array<NSDictionary>
                        */
                        self.topicData.append([
                            "_id": String(describing: x["_id"]!),
                            "name": String(describing: x["name"]!),
                            "createdBy": String(describing: x["createdBy"]!),
                            "createdAt": String(describing: x["createdAt"]!),
                            //"postCount": "0",
                            "description":  String(describing: x["description"]!)
                        ])
                    }
                } else {
                    self.topicData = []
                }

                self.sortedTopicData = self.topicData
                self.TopicList.reloadData()
                SVProgressHUD.dismiss()
                
            case .failure( _):
                print("f")
            }
        })
    }
}



extension ForumGroupController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var str = searchText
        
        if str == "" {
            sortedTopicData = topicData
        } else {
            sortedTopicData = topicData.filter{ $0["name"]!.lowercased().contains(str.lowercased()) }
        }
        
        TopicList.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
