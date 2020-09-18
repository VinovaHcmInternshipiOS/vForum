import Foundation
import UIKit

class LoginButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
