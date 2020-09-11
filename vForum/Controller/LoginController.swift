import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var Logo: UIImageView!
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Username.layer.cornerRadius = 7
        Password.layer.cornerRadius = 7
    }


}

