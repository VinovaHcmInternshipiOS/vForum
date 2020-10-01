import Foundation
import UIKit
import SnapKit
import Alamofire
import SVProgressHUD

class ForumController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var GroupItemList: UITableView!
    
    var groupName = "GroupName"
    var groupData: [[String:String]] = []
    var sortedGroupData: [[String:String]] = []
    
    var deletePopupState: Int = 0
    var goToNextView: Bool = true
    
    let def = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        
        let role = def.string(forKey: "role")!
        if role == "admin" {
            let btn1 = UIButton(type: .system)
            btn1.setImage(UIImage(named: "add"), for: .normal)
            btn1.tintColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00)
            
            btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn1.addTarget(self, action: #selector(addGroup), for: .touchUpInside)
            
            let item1 = UIBarButtonItem(customView: btn1)

            navigationItem.rightBarButtonItems = [item1]
        }
        
        GroupItemList.register(UINib(nibName: "GroupCellView", bundle: nil), forCellReuseIdentifier: "GroupCell")
        
        GroupItemList.delegate = self
        GroupItemList.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        navigationController!.isNavigationBarHidden = false
    }
    
    @objc func addGroup() {
        let vc = AddGroupController(nibName: "AddGroupView", bundle: nil)
        vc.modalPresentationStyle = .pageSheet
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedGroupData.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell

        cell.initCell()
        cell.setTitle(sortedGroupData[indexPath.row]["name"]!)
        cell.setTime(sortedGroupData[indexPath.row]["createdAt"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if goToNextView {
            let vc = ForumGroupController(nibName: "ForumGroupView", bundle: nil)
            
            vc.title = sortedGroupData[indexPath.row]["name"]
            def.set(sortedGroupData[indexPath.row]["_id"], forKey: "groupId")
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GroupCell
        deletePopupState = 0
        
        cell.SelectBackground.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            cell.CellEffect.frame.origin.x = -110
        }, completion: {action in
            guard self.def.string(forKey: "role")! == "admin" else {
                return
            }
            self.deletePopupState += 1
            
            if self.deletePopupState == 1 {
                self.showDeletePopup(indexPath)
            }
        })
        
    }
    
    func showDeletePopup(_ indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Delete group", message: "This group will be deleted permanently.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            self.goToNextView = true
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            let networkManager = NetworkManager.shared

            SVProgressHUD.show()
            let url : String = "http://localhost:4000/v1/api/group/\(String(describing: self.sortedGroupData[indexPath.row]["_id"]!))"
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(String(describing: self.def.object(forKey: "accessToken")!))"
            ]
            
            networkManager.request(url, method: .delete, parameters: [:], headers: headers).responseJSON(completionHandler: {respond in
                
                switch respond.result {
                case .success(_):
                    self.getData()
                    //self.GroupItemList.reloadData()
                    SVProgressHUD.dismiss()
                    
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
        let cell = tableView.cellForRow(at: indexPath) as! GroupCell
        cell.SelectBackground.isHidden = true
        
        UIView.animate(withDuration: 0.001, delay: 0, options: .curveEaseOut, animations: {
            cell.CellEffect.frame.origin.x = 220
        })
        deletePopupState = -1
    }
}







// MARK: - GET GROUP DATA
extension ForumController {
    func getData() {
        let networkManager = NetworkManager.shared
        
        let url : String = "http://localhost:4000/v1/api/group"
        let parameter : [String : Any] = [:]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(def.string(forKey: "accessToken")!)"
        ]
        
        networkManager.request(url, parameters: parameter, headers: headers).responseJSON(completionHandler: {respond in
            
            switch respond.result {
            case .success(let JSON):
                self.groupData = []
                let parsed = JSON as! NSDictionary
                
                if parsed["result"] != nil {
                    let result = parsed["result"] as! Array<NSDictionary>
                    for x in result {
                        self.groupData.append([
                            "name": String(describing: x["name"]!),
                            "_id": String(describing: x["_id"]!),
                            "createdAt": String(describing: x["createdAt"]!)
                        ])
                    }
                }
                
                
            case .failure( _):
                print("f")
            }
            self.sortedGroupData = self.groupData
            self.GroupItemList.reloadData()
            SVProgressHUD.dismiss()
        })
    }
}


extension ForumController: UISearchBarDelegate, UITextFieldDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let str = searchText
        
        if str == "" {
            sortedGroupData = groupData
        } else {
            sortedGroupData = groupData.filter{ $0["name"]!.lowercased().contains(str.lowercased()) }
        }
        
        GroupItemList.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
