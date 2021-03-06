//
//  CreationEventController.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class CreationEventController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var addEvent: ((Event) -> Void)?
    
    let stack = UIStackView()
    var titleTextField: UITextField?
    var descriptionTextField: UITextField?
    var startDateLbl: UILabel?
    var endDateLbl: UILabel?
    var collectionView: UICollectionView?
    var banner: String?
    var selectedIndex: IndexPath?
    var cancelBtn: UIButton?
    var saveBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initializeCancelBtn(&cancelBtn)
        initializeSaveBtn(&saveBtn)
        initializeInputTextArea()
        initializeCollectionView()
        saveBtn?.isEnabled = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width * 0.25, height: self.view.bounds.width * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventManager.shared.listBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerEventCell", for: indexPath)
        let imageView = UIImageView(image: UIImage(named: EventManager.shared.listBanner[indexPath.row]))
        imageView.contentMode = .scaleToFill
        imageView.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(imageView)
        cell.layer.borderWidth = selectedIndex == indexPath ? 5.0 : 0.0
        cell.layer.borderColor = UIColor.blue.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        banner = EventManager.shared.listBanner[indexPath.row]
        selectedIndex = indexPath
        
        if isEnoughInput() {
            saveBtn?.isEnabled = true
            saveBtn?.setTitleColor(UIColor(red: 39/255, green: 93/255, blue: 173/255, alpha: 1.0), for: .normal)
        }
        else {
            saveBtn?.isEnabled = false
            saveBtn?.setTitleColor(.lightGray, for: .normal)
        }
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    @objc func moveToDateTimePicker(sender: UITapGestureRecognizer) {
        guard let startDateLbl = startDateLbl, let endDateLbl = endDateLbl else {
            return
        }
        guard let startText = startDateLbl.text, let endText = endDateLbl.text else {
            return
        }
        
        let datePicker = DateTimePickerEvent()
        datePicker.modalPresentationStyle = .fullScreen
        datePicker.startDateTimePicker = UIDatePicker()
        datePicker.endDateTimePicker = UIDatePicker()
        if startDateLbl.text != "dd-mm-yyyy" {
            if let from = startText.toDate() {
                datePicker.startDateTimePicker?.date = from
            }
        }
        if endDateLbl.text != "dd-mm-yyyy" {
            if let to = endText.toDate() {
                datePicker.endDateTimePicker?.date = to
            }
        }
        
        datePicker.chooseDateTime = { startDate, endDate in
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            self.startDateLbl?.text = dateFormatter.string(from: startDate)
            self.endDateLbl?.text = dateFormatter.string(from: endDate)
            
            if self.isEnoughInput() {
                self.saveBtn?.isEnabled = true
                self.saveBtn?.setTitleColor(UIColor(red: 39/255, green: 93/255, blue: 173/255, alpha: 1.0), for: .normal)
            }
            else {
                self.saveBtn?.isEnabled = false
                self.saveBtn?.setTitleColor(.lightGray, for: .normal)
            }
            
        }
        present(datePicker, animated: true, completion: nil)
    }
    
    @objc func cancelBtnPressed(_ sender: UIButton) {
        closeVC()
    }
    
    @objc func saveBtnPressed(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextField?.text, let description = descriptionTextField?.text, let startDate = startDateLbl?.text, let endDate = endDateLbl?.text, let banner = banner else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        guard let start = dateFormatter.date(from: startDate), let end = dateFormatter.date(from: endDate) else {
            return
        }
        
        let event = EventManager.shared.createEvent(title: title, description: description, startDate: start, endDate: end, banner: banner)
        
        if let addEvent = addEvent {
            addEvent(event)
        }
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func closeVC() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func isEnoughInput() -> Bool {
        guard let title = titleTextField?.text, let description = descriptionTextField?.text, let startDate = startDateLbl?.text, let endDate = endDateLbl?.text, let banner = banner else {
            return false
        }
        
        if title.isEmpyOrSpacing() {
            return false
        }
        if description.isEmpyOrSpacing() {
            return false
        }
        if startDate == "dd-mm-yyyy" {
            return false
        }
        if endDate == "dd-mm-yyyy" {
            return false
        }
        
        if banner.isEmpty {
            return false
        }
        
        return true
    }

    
}


// TextField Delegate

extension CreationEventController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if isEnoughInput() {
            saveBtn?.isEnabled = true
            saveBtn?.setTitleColor(UIColor(red: 39/255, green: 93/255, blue: 173/255, alpha: 1.0), for: .normal)
        }
        else {
            saveBtn?.isEnabled = false
            saveBtn?.setTitleColor(.lightGray, for: .normal)
        }
    }
}
