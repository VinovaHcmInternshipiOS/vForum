import Foundation
import UIKit
import Alamofire

class ForumGroupController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TopicList: UITableView!
    
    var postCounts:[Int] = [35,950]
    var topicData:[[String:String]] = [[:]]
    
    // MARK: - ADD TOPIC
    @IBAction func addTopic() {

    }

    // MARK: - SORT TOPIC
    @IBAction func sortTopic() {
        let choiceBox = UIAlertController(title: "Sort posts", preferredStyle: .actionSheet)
        // MARK: -- SORT
        choiceBox.addAction(UIAlertAction(title: "Newest first"), style: .default, handler: { action in 
                //myArray.sort{
                    //(($0 as! Dictionary<String, AnyObject>)["d"] as? Int) < (($1 as! Dictionary<String, AnyObject>)["d"] as? Int)
                //}
                TopicList.reloadData()
            }
        )
        choiceBox.addAction(UIAlertAction(title: "Oldest first"), style: .default, handler: { action in 
                // SORT BY OLDEST FIRST
                TopicList.reloadData()
            }
        )
        choiceBox.addAction(UIAlertAction(title: "Most active"), style: .default, handler: { action in 
                // SORT BY NEWEST FIRST
                TopicList.reloadData()
            }
        )
        choiceBox.addAction(UIAlertAction(title: "Cancel"), style: .cancel, handler: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

        TopicList.backgroundColor = .clear
        TopicList.register(UINib(nibName: "TopicCellView", bundle: nil), forCellReuseIdentifier: "TopicCell")
        
        TopicList.delegate = self
        TopicList.dataSource = self
        
        topicData.append([
            "_id":"blahblahblah",
            "name":"Topic title",
            "createdBy":"aland",
            "createdAt":"22/09/2020, 18:54"
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func getData() {
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicData.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
    
        cell.initCell()

        cell.setTitle(topicData[indexPath.row]["name"])
        cell.setPostCount(postCounts[indexPath.row])
        cell.setCreator(topicData[indexPath.row]["createdAt"])

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ForumTopicController(nibName: "ForumTopicView", bundle: nil)
        vc.setTitle(topicData[indexPath.row]["name"])
        vc.setSubtitle(name: topicData[indexPath.row]["createdBy"], date: topicData[indexPath.row]["createdAt"])
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopicCell
        cell.MainView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopicCell
        
        cell.MainView.backgroundColor = UIColor.white
        
    }
    
}
