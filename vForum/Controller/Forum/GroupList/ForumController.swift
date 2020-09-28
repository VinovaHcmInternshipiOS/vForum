import Foundation
import UIKit
import SnapKit

class ForumController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var GroupItemList: UITableView!
    
    var groupName = "GroupName"
    var groupData: [[String:String]] = []
    
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
        //let vc = AddGroupController(nibName: "AddGroupView", bundle: nil)
        //navigationController?.pushViewController(vc, animated: true)
        print("yeet")
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
        
        vc.title = "Group name"
        
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
        groupData.append([
            "name": "HTML-123",
            "_id": "5f5ad674672ec61dc0c05185",
            "createdAt": "2020-09-28T01:44:20.987Z"
        ])
        
        groupData.append([
            "name": "C++",
            "_id": "5f5ad674672ec61dc0c05185",
            "createdAt": "2020-09-11T01:44:20.987Z"
        ])
    }
}
