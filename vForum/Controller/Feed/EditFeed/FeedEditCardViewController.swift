//
//  FeedEditCardViewController.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/28/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import UIKit
import SnapKit

class FeedEditCardViewController: UIViewController {

    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var feedID: String?
    var imageArray = [UIImage]()
    var urlArray = [String]()
    var reload: (()->Void)? = nil
    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjZiZmQ5ZTRjMDFiYjQxODhjMTEyYzciLCJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwicm9sZSI6ImFkbWluIiwiZGlzcGxheV9uYW1lIjoiMTIzNDU2Nzg5IiwiaWF0IjoxNjAxNDc0NTM0LCJleHAiOjE2MDIwNzkzMzR9.Mk4ukqvcqYqJ2aOJadNe4TlvXMY5j7AifCCzZANSkK4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FeedCreateButtonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedCreateButtonCollectionViewCell")
        collectionView.register(UINib(nibName: "FeedLoadImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedLoadImageCollectionViewCell")
        self.navigationItem.title = "Edit"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 20)!]
        if #available(iOS 13.0, *) {
            let btnCreate = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DONE))
            self.navigationItem.rightBarButtonItem  = btnCreate
        } else {
            // Fallback on earlier versions
        }
        self.txtView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        setContraints()
        setLayer()
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
}

extension FeedEditCardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == imageArray.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCreateButtonCollectionViewCell", for: indexPath) as! FeedCreateButtonCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedLoadImageCollectionViewCell", for: indexPath) as! FeedLoadImageCollectionViewCell
            cell.imageUpload.image = imageArray[indexPath.row]
            cell.deleteImage = {
                self.imageArray.remove(at: indexPath.row)
                collectionView.reloadData()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == imageArray.count {
            showActionSheet()
        }
    }
}

extension FeedEditCardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 2*collectionView.frame.width/5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension FeedEditCardViewController {
    @objc func DONE(){
        editFeedAPI()
        self.navigationController?.popViewController(animated: true)
    }
}

extension FeedEditCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showActionSheet() {
        let alert = UIAlertController(title: "Attachments", message: "Choose an option to continue", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            print("User click Camera")
            self.getImage(fromSourceType: .camera)
        }))

        alert.addAction(UIAlertAction(title: "Library", style: .default , handler:{ (UIAlertAction)in
            print("User click Library")
            self.getImage(fromSourceType: .photoLibrary)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Cancel")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let originImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            selectedImageFromPicker = originImage
        }
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        if let selectedImage = selectedImageFromPicker {
            imageArray.append(selectedImage)
            collectionView.reloadData()
        }
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension FeedEditCardViewController{
    func setContraints(){
        viewContain.snp.makeConstraints{ (make)->Void in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalToSuperview()
        }
        txtView.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(viewContain).offset(50)
            make.right.equalTo(viewContain).offset(-20)
            make.left.equalTo(viewContain).offset(20)
            make.height.equalTo(viewContain).multipliedBy(0.5)
        }
        collectionView.snp.makeConstraints{ (make)->Void in
            make.top.equalTo(txtView.snp_bottom).offset(20)
            make.left.equalTo(txtView)
            make.right.equalTo(txtView)
            make.height.equalTo(txtView).multipliedBy(0.3)
        }
    }
    
    func setLayer(){
        txtView.layer.borderColor = UIColor.gray.cgColor
        txtView.layer.borderWidth = 0.5
        txtView.layer.cornerRadius = 3
    }
}

extension FeedEditCardViewController {
    func editFeedAPI(){
        let remoteProvider = RemoteAPIProvider(configuration: FeedAppServerConfiguration.allTime)
        remoteProvider.requestFreeJSON(target: FeedMethod.editFeed(feedID: feedID ?? "", description: txtView.text, attachments: urlArray), accessToken: self.token, fullfill: { (data) in
            print(data)})
        { (err) in
            AlertView.showAlert(view: self, message: err.localizedDescription, title: "Error")
        }
        DispatchQueue.main.async {
            self.reload?()
        }
    }
}
