import Foundation
import UIKit
import Alamofire

class ForumGroupController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TopicList: UITableView!
    @IBOutlet weak var SearchBar: UITextField!
    
    var postCounts:[Int] = [35,950]
    var topicData:[[String:String]] = []
    var sortedTopicData:[[String:String]] = []
    
    // MARK: - ADD TOPIC
    @objc func addTopic() {
        let vc = AddTopicController(nibName: "AddTopicView", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - SORT TOPIC
    @objc func sortTopic() {
        let choiceBox = UIAlertController(title: "Sort posts", message: "", preferredStyle: .actionSheet)
        // MARK: -- SORT
        choiceBox.addAction(UIAlertAction(title: "Newest first", style: .default, handler: { action in
                self.topicData.sort {
                    (self.convertToDateTime($0["createdAt"]!) > self.convertToDateTime($1["createdAt"]!))
                }
                self.sortedTopicData = self.topicData
                self.TopicList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Oldest first", style: .default, handler: { action in
                self.topicData.sort {
                    (self.convertToDateTime($0["createdAt"]!) < self.convertToDateTime($1["createdAt"]!))
                }
                self.sortedTopicData = self.topicData
                self.TopicList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Most posts", style: .default, handler: { action in
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
        btn1.addTarget(self, action: #selector(addTopic), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)

        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "sort"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(sortTopic), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)

        navigationController!.navigationItem.setRightBarButtonItems([item1,item2], animated: true)

        TopicList.backgroundColor = .clear
        TopicList.register(UINib(nibName: "TopicCellView", bundle: nil), forCellReuseIdentifier: "TopicCell")
        
        TopicList.delegate = self
        TopicList.dataSource = self
        
        topicData.append([
            "_id":"blahblahblah",
            "name":"Topic title",
            "createdBy":"aland",
            "createdAt":"2020-09-16T03:00:56.880Z"
        ])
        
        topicData.append([
            "_id":"blahblahblah",
            "name":"Another topic",
            "createdBy":"aland",
            "createdAt":"2020-09-16T03:00:56.880Z"
        ])

        sortedTopicData = topicData
    }
    
    func convertToDateTime(_ str: String)->Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: str)!

        return date
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    //override func viewWillDisappear(_ animated: Bool) {
    //    navigationController?.navigationBar.isHidden = true
    //}
    
    func getData() {
        
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
        cell.setPostCount(postCounts[indexPath.row])
        cell.setCreator(sortedTopicData[indexPath.row]["createdAt"] ?? "")

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ForumTopicController(nibName: "ForumTopicView", bundle: nil)
        vc.setTitle(sortedTopicData[indexPath.row]["name"] ?? "")
        vc.setCreator(sortedTopicData[indexPath.row]["createdBy"] ?? "")
        vc.setDateTime(sortedTopicData[indexPath.row]["createdAt"] ?? "")
        
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
