import Foundation
import UIKit
import Alamofire

class ForumGroupController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TopicList: UITableView!
    @IBOutlet weak var SearchBar: UITextField!
    
    var topicData:[[String:String]] = []
    var sortedTopicData:[[String:String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        getData()
        
        let btn1 = UIButton(type: .system)
        btn1.setImage(UIImage(named: "add"), for: .normal)
        btn1.tintColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00)
        
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(addTopic), for: .touchUpInside)
        
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .system)
        btn2.setImage(UIImage(named: "sort"), for: .normal)
        btn2.tintColor = UIColor(red: 0.15, green: 0.36, blue: 0.68, alpha: 1.00)
        
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(sortTopic), for: .touchUpInside)
        
        let item2 = UIBarButtonItem(customView: btn2)

        navigationItem.rightBarButtonItems = [item1, item2]

        TopicList.backgroundColor = .clear
        TopicList.register(UINib(nibName: "TopicCellView", bundle: nil), forCellReuseIdentifier: "TopicCell")
        
        TopicList.delegate = self
        TopicList.dataSource = self

        sortedTopicData = topicData
    }
    
    
    // MARK: - ADD TOPIC
    @objc func addTopic() {
        let vc = AddTopicController(nibName: "AddTopicView", bundle: nil)
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
        choiceBox.addAction(UIAlertAction(title: "Most posts", style: .default, handler: { action in
                self.sortedTopicData.sort {
                    (Int($0["postCount"]!) ?? 0) > (Int($1["postCount"]!) ?? 0)
                }
                self.TopicList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(choiceBox, animated: true)
    }
    
    func convertToDateTime(_ str: String)->Date {
        let dateFormatter = ISO8601DateFormatter()
        let trimmedIsoString = str.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        let date = dateFormatter.date(from: trimmedIsoString)!
        
        return date
    }

    override func viewDidAppear(_ animated: Bool) {
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




// MARK: - GET DATA

extension ForumGroupController {
    func getData() {
        topicData.append([
            "_id":"blahblahblah",
            "name":"Topic title",
            "createdBy":"aland",
            "createdAt":"2020-09-25T18:00:56.880Z",
            "postCount":"43"
        ])
        
        topicData.append([
            "_id":"blahblahblah",
            "name":"A longer topic name to fit two lines omg this is cool",
            "createdBy":"aland",
            "createdAt":"2020-09-16T03:00:56.880Z",
            "postCount":"250"
        ])
        
        topicData.append([
            "_id":"blahblahblah",
            "name":"Three lines three lines three lines oh yes baby gotta extend this shit oh fuck how long is this",
            "createdBy":"dominic",
            "createdAt":"2020-10-03T21:56:00.330Z",
            "postCount":"6350"
        ])
    }
}
