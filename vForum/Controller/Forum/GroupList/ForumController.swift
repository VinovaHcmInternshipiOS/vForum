import Foundation
import UIKit
import SnapKit
import Alamofire

class ForumController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var GroupItemList: UITableView!
    
    var groupName = "GroupName"
    var groupData: [[String:String]] = []
    
    let def = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        let btn1 = UIButton(type: .system)
        btn1.setImage(UIImage(named: "add"), for: .normal)
        btn1.tintColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00)
        
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(addGroup), for: .touchUpInside)
        
        let item1 = UIBarButtonItem(customView: btn1)

        navigationItem.rightBarButtonItems = [item1]
        
        GroupItemList.register(UINib(nibName: "GroupCellView", bundle: nil), forCellReuseIdentifier: "GroupCell")
        
        GroupItemList.delegate = self
        GroupItemList.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController!.isNavigationBarHidden = false
    }
    
    @objc func addGroup() {
        let vc = AddGroupController(nibName: "AddGroupView", bundle: nil)
        vc.modalPresentationStyle = .pageSheet
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupData.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell

        cell.initCell()
        cell.setTitle(groupData[indexPath.row]["name"]!)
        cell.setTime(groupData[indexPath.row]["createdAt"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ForumGroupController(nibName: "ForumGroupView", bundle: nil)
        
        vc.title = groupData[indexPath.row]["name"]
        def.set(groupData[indexPath.row]["_id"], forKey: "groupId")
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GroupCell
        
        cell.SelectBackground.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            cell.CellEffect.frame.origin.x = -110
        })
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GroupCell
        cell.SelectBackground.isHidden = true
        
        UIView.animate(withDuration: 0.001, delay: 0, options: .curveEaseOut, animations: {
            cell.CellEffect.frame.origin.x = 220
        })
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
                
                self.GroupItemList.reloadData()
                
            case .failure( _):
                print("f")
            }
        })
    }
}
