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

    enum SideDateTimeEvent {
        case right, left
    }
    var blueColor: UIColor? = UIColor(red: 39/255, green: 93/255, blue: 173/255, alpha: 1.0)
    
    
    var event: Event?
    var cancelBtn: UIButton?
    var saveBtn: UIButton?
    var bannerImgView: UIImageView?
    var titleLbl: UITextField?
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
        closeVC()
    }
    
    @objc func remindBtnPressed(_ sender: UIButton) {
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
        let dateTimePicker = DateTimePickerEvent()
        guard let startDateLbl = startDateLbl, let startTimeLbl = startTimeLbl, let endDateLbl = endDateLbl, let endTimeLbl = endTimeLbl else {
            return
        }
        let startString: String = startDateLbl.text! + " " + startTimeLbl.text!
        let endString: String = endDateLbl.text! + " " + endTimeLbl.text!
        
        guard let from = startString.toDate(), let to = endString.toDate() else {
            return
        }
        dateTimePicker.startDateTimePicker?.date = from
        dateTimePicker.endDateTimePicker?.date = to
    }
}
