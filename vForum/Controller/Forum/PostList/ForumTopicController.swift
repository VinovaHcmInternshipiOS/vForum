import Foundation
import UIKit
import Alamofire

class ForumTopicController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var postList: UITableView!
    @IBOutlet weak var searchBar: UITextField!

    var postTitle: String = ""
    
    var topicTitleLineCount: Int = 0

    var cellHeights: [CGFloat] = []

    private(set) var postData:[[String:String]] = []
    private(set) var sortedPostData:[[String:String]] = []
    
    private(set) var topicTitle: String = ""
    private(set) var topicCreator: String = ""
    private(set) var topicDateTime: String = ""
    private(set) var topicId: String = ""
    

    @IBAction func add(_ sender: UIButton) {
        let vc = AddViewController(nibName: "AddViewController", bundle: nil)
        navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func sort(_ sender: UIButton) {
        let choiceBox = UIAlertController(title: "Sort posts", message: "", preferredStyle: .actionSheet)
        // MARK: -- SORT
        choiceBox.addAction(UIAlertAction(title: "Newest first", style: .default, handler: { action in
                postData.sort {
                    (convertToDateTime($0["createdAt"]) > convertToDateTime($1["createdAt"]))
                }
                sortedPostData = postData
                self.postList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Oldest first", style: .default, handler: { action in
                postData.sort {
                    (convertToDateTime($0["createdAt"]) < convertToDateTime($1["createdAt"]))
                }
                sortedPostData = postData
                self.postList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Most likes", style: .default, handler: { action in
                postData.sort {
                    (Int($0["countLike"]) ?? 0 > Int($1["countLike"]) ?? 0)
                }
                sortedPostData = postData
                self.postList.reloadData()
            })
        )
        choiceBox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(choiceBox, animated: true)
    }

    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        postData.append([
            "title":"Post Title",
            "description":"Lorem ipsum donor amet boi",
            "createdAt":"2020-09-16T03:00:56.880Z",
            "createdBy":"dominic",
            "_id":"12d342389cf29d",
            "countLike":"232"
        ])

        postData.append([
            "title":"Another iOS 14 description",
            "description":"Lorem ipsum donor amet boi",
            "createdAt":"2020-09-19T11:00:56.880Z",
            "createdBy":"dominic",
            "_id":"12d342389cf29d"
            "countLike":"0"
        ])
        
        postData.append([
            "title":"Post name to fit two lines omg please heck yes boi can we have more stuff",
            "description":"Lorem ipsum donor amet boi",
            "createdAt":"2020-09-25T12:00:56.880Z",
            "createdBy":"dominic",
            "_id":"12d342389cf29d"
            "countLike":"12"
        ])
        
        postData.append([
            "title":"Another iOS 14 description",
            "description":"Lorem ipsum donor amet boi",
            "createdAt":"2020-09-30T15:00:56.880Z",
            "createdBy":"dominic",
            "_id":"12d342389cf29d"
            "countLike":"1950"
        ])

        sortedPostData = postData

        cellHeights.append(0)
        cellHeights.append(0)
        cellHeights.append(0)
        cellHeights.append(0)
        
        getData()
        
        postList.rowHeight = UITableView.automaticDimension
        postList.estimatedRowHeight = 250
        
        postList.register(UINib(nibName: "PostPreviewCellView", bundle: nil), forCellReuseIdentifier: "Post")
        postList.register(UINib(nibName: "TopicTitleCellView", bundle: nil), forCellReuseIdentifier: "TopicTitle")
        navigationController?.navigationBar.isHidden = true
        
        postList.delegate = self
        postList.dataSource = self
    }
    
    func convertToDateTime(_str: String)->Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!

        return date
    }

    // MARK: - GET DATA
    func getData() {
        
    }

    func setTitle(_ str: String) {
        topicTitle = str
    }

    func setCreator(_ str: String) {
        topicCreator = str
    }
    
    func setDateTime(_ str: String) {
        topicDateTime = str
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPostData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTitle", for: indexPath) as! TopicTitleCell

            cell.backgroundColor = UIColor.clear

            // MARK: -- ADD DATA

            cell.setTitle(topicTitle)
            cell.setCreator(topicCreator)
            cell.setDatetime(topicDateTime)
            
            topicTitleLineCount = cell.getTitleLineCount()
            cell.selectionStyle = .none
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! PostPreviewCell
            
            cellHeights[indexPath.row-1] = cell.getCellHeight()

            cell.setTitle(sortedPostData[indexPath.row - 1]["title"]!)
            cell.setContent(sortedPostData[indexPath.row - 1]["description"]!)
            cell.setDateTime(sortedPostData[indexPath.row - 1]["createdAt"]!)
            cell.setCreator(sortedPostData[indexPath.row - 1]["createdBy"]!)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return CGFloat(topicTitleLineCount * 30 + 60)
        default:
            return cellHeights[indexPath.row - 1]
            //return 350
        }
    }
}




extension ForumTopicController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {

    }

    func textFieldShouldReturn(_ textField: UITextField) {

    }
}
