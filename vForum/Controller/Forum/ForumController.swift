import Foundation
import UIKit
import SnapKit

class ForumController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var GroupItemList: UITableView!
    
    var groupName = "GroupName"
    var groupImageURLs:[String] = []
    var groupLabels:[String] = []
    var groupActivateTimes:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GroupItemList.register(UINib(nibName: "GroupCellView", bundle: nil), forCellReuseIdentifier: "GroupCell")
        
        GroupItemList.delegate = self
        GroupItemList.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell

        cell.initCell()
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
