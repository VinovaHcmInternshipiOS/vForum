import Foundation
import UIKit

class ForumGroupController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TopicList: UITableView!
    
    var topicData: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopicList.backgroundColor = .clear
        
        TopicList.register(UINib(nibName: "TopicCellView", bundle: nil), forCellReuseIdentifier: "TopicCell")
        
        TopicList.delegate = self
        TopicList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 8
        
        return cell
    }
}
