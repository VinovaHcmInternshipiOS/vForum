import UIKit
import SnapKit
import Alamofire

class AddGroupController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let def = UserDefaults.standard
    
    @IBOutlet weak var AddImageButton: UIButton!
    @IBOutlet weak var BGImage: UIImageView!
    @IBOutlet weak var GroupNameField: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!
    
    @IBAction func AddImage(_ sender: UIButton) {
        let selector = UIImagePickerController()
        selector.delegate = self
        selector.mediaTypes = ["public.image"]
        
        present(selector, animated: true)
    }
    
    @IBAction func Submit(_ sender: UIButton) {
        let name = GroupNameField.text!
        let networkManager = NetworkManager.shared
        
        let url : String = "http://localhost:4000/v1/api/group"
        let parameter : [String : Any] = ["name": name]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(def.string(forKey: "accessToken")!)"
        ]
        
        networkManager.request(url, method: .post, parameters: parameter, headers: headers).responseJSON(completionHandler: {respond in
            
            switch respond.result {
            case .success(let JSON):
                let parsed = JSON as! NSDictionary
                if String(describing: parsed["success"]!) == "1" {
                    self.navigationController!.popViewController(animated: true)
                } else {
                    let alert = UIAlertController(title: "Error!", message: String(describing: parsed["message"]!), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                print(parsed)
                
            case .failure( _):
                print("f")
            }
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
            
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            AddImageButton.setBackgroundImage(image, for: .normal)
            AddImageButton.setTitle("", for: .normal)
            AddImageButton.contentMode = .scaleAspectFill
            BGImage.image = image
        }
    }
}
