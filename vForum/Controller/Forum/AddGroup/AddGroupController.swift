import UIKit
import SnapKit

class AddGroupController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
        let groupName = GroupNameField.text!
        // MARK: - ADD GROUP
        
        navigationController!.popViewController(animated: true)
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
