import Foundation
import UIKit
import Alamofire

class ForumGroupController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TopicList: UITableView!
    @IBOutlet weak var SearchBar: UITextField!
    
    var postCounts:[Int] = [35,950]
    var topicData:[[String:String]] = []
    
    // MARK: - ADD TOPIC
    @IBAction func addTopic() {

    }

    // MARK: - SORT TOPIC
    @IBAction func sortTopic() {
        let choiceBox = UIAlertController(title: "Sort posts", message: "", preferredStyle: .actionSheet)
        // MARK: -- SORT
        choiceBox.addAction(UIAlertAction(title: "Newest first", style: .default, handler: { action in
                //myArray.sort{
                    //(($0 as! Dictionary<String, AnyObject>)["d"] as? Int) < (($1 as! Dictionary<String, AnyObject>)["d"] as? Int)
                //}
                //TopicList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Oldest first", style: .default, handler: { action in
                // SORT BY OLDEST FIRST
                //TopicList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Most active", style: .default, handler: { action in
                // SORT BY NEWEST FIRST
                //TopicList.reloadData()
                print("yeet")
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "add"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //btn1.addTarget(self, action: #selector(nil), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)

        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "sort"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //btn2.addTarget(self, action: #selector(nil), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)

        navigationController?.navigationItem.setRightBarButtonItems([item1,item2], animated: true)

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
        
        topicData.append([
            "_id":"blahblahblah",
            "name":"Another topic",
            "createdBy":"aland",
            "createdAt":"01/09/2020, 18:54"
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
    
        print(topicData)
        
        cell.initCell()
            
        cell.setTitle(topicData[indexPath.row]["name"] ?? "")
        cell.setPostCount(postCounts[indexPath.row])
        cell.setCreator(topicData[indexPath.row]["createdAt"] ?? "")

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ForumTopicController(nibName: "ForumTopicView", bundle: nil)
        vc.setTitle(topicData[indexPath.row]["name"] ?? "")
        vc.setCreator(topicData[indexPath.row]["createdBy"] ?? "")
        vc.setDateTime(topicData[indexPath.row]["createdAt"] ?? "")
        
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
