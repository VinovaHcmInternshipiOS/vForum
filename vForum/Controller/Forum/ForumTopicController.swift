import Foundation
import UIKit
import SnapKit

class ForumTopicController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var postlist: UITableView!
    
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
        postlist.register(UINib(nibName: "PostDetailViewController", bundle: nil), forCellReuseIdentifier: "Post")
        navigationController?.navigationBar.isHidden = true
    }
    
    func setTitle(_ str: String) {
        postTitle?.text = str
    }
    
    func setSubtitle(name: String, date: String) {
        subtitle?.text = "@\(name) · date"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath)
        
        return cell
    }
}
