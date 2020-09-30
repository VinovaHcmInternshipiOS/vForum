//
//  DateTimePickerEventController.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class DateTimePickerEvent: UIViewController {
    var picker : UIDatePicker?
    var cancelBtn: UIButton?
    var saveBtn: UIButton?
    
    var isSorting: Bool?
    var sortDateTime: ((Date, Date) -> Void)?
    var chooseDateTime: ((Date, Date) -> Void)?
    
    // Start DateTime Area
    var startDateTimeStackView: UIStackView?
    var startDateTimeLabel: UILabel?
    var startDateTimePicker: UIDatePicker?
    
    // End DateTime Area
    var endDateTimeStackView: UIStackView?
    var endDateTimeLabel: UILabel?
    var endDateTimePicker: UIDatePicker?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initializeCancelBtn(&cancelBtn)
        initializeSaveBtn(&saveBtn)
        initilizeDateTimeArea(stackView: &startDateTimeStackView, label: &startDateTimeLabel, datePicker: &startDateTimePicker, self.view.bounds.height * 0.1, "From: ")
        initilizeDateTimeArea(stackView: &endDateTimeStackView, label: &endDateTimeLabel, datePicker: &endDateTimePicker, self.view.bounds.height * 0.5, "End: ")
        
    }
    
    @objc func cancelBtnPressed(_ sender: UIButton) {
        closeVC()
    }
    
    @objc func saveBtnPressed(_ sender: UIButton) {
        guard let startDate = startDateTimePicker?.date, let endDate = endDateTimePicker?.date else {
            return
        }
        
        if let isSorting = isSorting, let sortDateTime = sortDateTime {
            if isSorting == true {
                sortDateTime(startDate, endDate)
                
                DispatchQueue.main.async {
                    self.closeVC()
                }
                return
            }
        }
        
        if let chooseDateTime = chooseDateTime {
            chooseDateTime(startDate, endDate)
            
            DispatchQueue.main.async {
                self.closeVC()
            }
        }
    }
    
    func closeVC() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
