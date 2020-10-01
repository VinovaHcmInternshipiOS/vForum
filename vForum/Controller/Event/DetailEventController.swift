//
//  DetailEventController.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class DetailEventController: UIViewController {

    var editEvent: (() -> Void)?
    
    enum SideDateTimeEvent {
        case right, left
    }
    var blueColor: UIColor? = UIColor(red: 39/255, green: 93/255, blue: 173/255, alpha: 1.0)
    
    
    var event: Event?
    var cancelBtn: UIButton?
    var saveBtn: UIButton?
    var bannerImgView: UIImageView?
    var titleTxtField: UITextField?
    var descriptionTxtView: UITextView?
    var startStackView: UIStackView?
    var startDateLbl: UILabel?
    var startTimeLbl: UILabel?
    var endStackView: UIStackView?
    var endDateLbl: UILabel?
    var endTimeLbl: UILabel?
    var remindBtn: UIButton?
    var remindCell: UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initializeCancelBtn(&cancelBtn)
        initializeSaveBtn(&saveBtn)
        initializeViews()
        
    }
    @objc func cancelBtnPressed(_ sender: UIButton) {
        closeVC()
    }
    
    @objc func saveBtnPressed(_ sender: UIButton) {
        guard let event = event else {
            return
        }
        guard let titleTxtField = titleTxtField, let descriptionTxtView = descriptionTxtView, let startDateLbl = startDateLbl, let startTimeLbl = startTimeLbl, let endDateLbl = endDateLbl, let endTimeLbl = endTimeLbl else {
            return
        }
        let startString: String = startDateLbl.text! + " " + startTimeLbl.text!
        let endString: String = endDateLbl.text! + " " + endTimeLbl.text!
        
        guard let from = startString.toDate(), let to = endString.toDate() else {
            return
        }
        if self.isEditing == true {
            self.isEditing = false
            updateEditMode()
            EventManager.shared.updateEvent(id: event._id, title: titleTxtField.text!, description: descriptionTxtView.text, startDate: from, endDate: to)
            saveBtn?.setTitle("Edit", for: .normal)
            if let editEvent = editEvent {
                editEvent()
            }
            closeVC()
        }
        else {
            self.isEditing = true
            updateEditMode()
            saveBtn?.setTitle("Save", for: .normal)
        }
    }
    
    @objc func remindBtnPressed(_ sender: UIButton) {
        if self.isEditing == false {
            return
        }
        
        let repeatPicker = RemindViewController()
        repeatPicker.chose = event?.repeated
        repeatPicker.changeRemindTime = { value in
            self.event?.repeated = value
            self.remindCell?.textLabel?.text = self.event?.repeated.toString()
        }
        
        present(repeatPicker, animated: true, completion: nil)
    }
    
    func closeVC() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func editDateTimeButonPressed(_ sender: UIButton) {
        if self.isEditing == false {
            return
        }
        let dateTimePicker = DateTimePickerEvent()
        dateTimePicker.modalPresentationStyle = .fullScreen
        
        guard let startDateLbl = startDateLbl, let startTimeLbl = startTimeLbl, let endDateLbl = endDateLbl, let endTimeLbl = endTimeLbl else {
            return
        }
        let startString: String = startDateLbl.text! + " " + startTimeLbl.text!
        let endString: String = endDateLbl.text! + " " + endTimeLbl.text!
        
        guard let from = startString.toDate(), let to = endString.toDate() else {
            return
        }
        dateTimePicker.startDateTimePicker = UIDatePicker()
        dateTimePicker.endDateTimePicker = UIDatePicker()
        dateTimePicker.startDateTimePicker?.date = from
        dateTimePicker.endDateTimePicker?.date = to
        dateTimePicker.chooseDateTime = { (from, to) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            startDateLbl.text = dateFormatter.string(from: from)
            startTimeLbl.text = "\(Calendar.current.component(.hour, from: from)):\(Calendar.current.component(.minute, from: from))"
            endDateLbl.text = dateFormatter.string(from: to)
            endTimeLbl.text = "\(Calendar.current.component(.hour, from: from)):\(Calendar.current.component(.minute, from: to))"
        }
        
        DispatchQueue.main.async {
            self.present(dateTimePicker, animated: true, completion: nil)
        }
    }
    
    func updateEditMode() {
        titleTxtField?.isEnabled = isEditing
        descriptionTxtView?.isEditable = isEditing
        remindCell?.accessoryType = isEditing ? .disclosureIndicator : .none
    }
}
