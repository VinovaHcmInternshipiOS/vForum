import Foundation
import UIKit

class ForumTopicController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postList: UITableView!
    var postTitle: String = ""
    
    var postTitleLineCount: Int = 0
    var cellHeights: [CGFloat] = []
    
    @IBAction func add(_ sender: Any) {
        let vc = AddViewController(nibName: "AddViewController", bundle: nil)
        navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postList.rowHeight = UITableView.automaticDimension
        postList.estimatedRowHeight = 250
        
        postList.register(UINib(nibName: "PostPreviewCellView", bundle: nil), forCellReuseIdentifier: "Post")
        postList.register(UINib(nibName: "TopicTitleCellView", bundle: nil), forCellReuseIdentifier: "TopicTitle")
        navigationController?.navigationBar.isHidden = true
        
        postList.delegate = self
        postList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTitle", for: indexPath) as! TopicTitleCell

            cell.backgroundColor = UIColor.clear
            cell.setTitle("A very long long long title that makes it to the 3rd line omg please heck yes boi")
            cell.setCreator("newcomer")
            cell.setDatetime("22/09/2020, 18:05")
            postTitleLineCount = cell.getTitleLineCount()
             
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! PostPreviewCell
            cellHeights.append(cell.getCellHeight())
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return CGFloat(postTitleLineCount * 30 + 60)
        default:
            print(indexPath.row-1)
            return cellHeights[indexPath.row - 1]
        }
    }
}
