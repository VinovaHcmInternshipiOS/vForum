import Foundation
import UIKit
import SnapKit

class SignUpController: UIViewController {
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController!.popViewController(animated: true)
    }
}
