import UIKit
import SnapKit
import Alamofire

class AddViewController: UIViewController {
    @IBOutlet weak var scrollMainViewOutlet: UIScrollView!
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var saveOutlet: UIButton!
    @IBOutlet weak var titleOutlet: UITextField!
    @IBOutlet weak var descriptionOutlet: UITextView!
    @IBOutlet weak var mainViewOutlet: UIView!
    
    let def = UserDefaults.standard
    
    var mode = "post"
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpItem()
        // Do any additional setup after loading the view.
    }


    private func setUpItem(){
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: titleOutlet.frame.height, width: titleOutlet.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.black.cgColor
        titleOutlet.layer.addSublayer(bottomLine)
        
        scrollMainViewOutlet.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.top.equalTo(self.view).offset(0.0)
            make.bottom.equalTo(self.view.snp_bottom).offset(-5)
        }
        
        mainViewOutlet.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(self.view.bounds.width - 2)
            make.top.leading.equalTo(scrollMainViewOutlet).offset(1)
//            make.trailing.equalTo(scrollMainViewOutlet).offset(-1)
            make.centerY.equalTo(scrollMainViewOutlet.snp_centerY)
            make.bottom.equalTo(scrollMainViewOutlet.snp_bottom).offset(-1)
        }

        cancelOutlet.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(mainViewOutlet.snp_top).offset(10)
            make.leading.equalTo(mainViewOutlet.snp_leading).offset(10)
        }

        saveOutlet.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(mainViewOutlet.snp.top).offset(10)
            make.trailing.equalTo(mainViewOutlet.snp_trailing).offset(-10)
        }

        titleOutlet.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.top.equalTo(cancelOutlet.snp_bottom).offset(10)
            make.leading.equalTo(mainViewOutlet.snp_leading).offset(10)
            make.trailing.equalTo(mainViewOutlet.snp_trailing).offset(-10)
        }

        descriptionOutlet.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(100)
            make.top.equalTo(titleOutlet.snp_bottom).offset(10)
            make.leading.equalTo(mainViewOutlet).offset(10)
            make.trailing.equalTo(mainViewOutlet).offset(-10)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        let networkManager = NetworkManager.shared
        
        switch mode {
        case "post":
            let url : String = "http://localhost:4000/v1/api/group/\(def.string(forKey: "groupId")!)/topic/\(def.string(forKey: "topicId")!)/post"
            let parameter : [String : Any] = ["title": titleOutlet.text!, "description": descriptionOutlet.text!]
            
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(String(describing: def.object(forKey: "accessToken")!))"
            ]
            
            networkManager.request(url, method: .post, parameters: parameter, headers: headers).responseJSON(completionHandler: {respond in
                
                switch respond.result {
                case .success(let JSON):
                    let parsed = JSON as! NSDictionary
                    print(parsed)
                    
                    if parsed["result"] != nil && String(describing: parsed["result"]!) != "<null>" {
                        self.navigationController!.popViewController(animated: true)
                    } else {
                        let alert = UIAlertController(title: "Error!", message: String(describing: parsed["message"]!), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in self.navigationController!.popViewController(animated: true)}))
                        self.present(alert, animated: true)
                    }
                    
                    
                    
                case .failure( _):
                    print("f")
                }
            })
            
        case "topic":
            print("topic")
            
        default:
            print("error")
        }
    }
}
