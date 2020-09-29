import Foundation
import UIKit

class SignUpField: UICollectionViewCell {
    @IBOutlet weak var Underline: UIView!
    @IBOutlet weak var TextField: UITextField!
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var RequiredFieldLabel: UILabel!
    @IBOutlet weak var MaleFemale: UISegmentedControl!
    
    var required: Bool = false
}
