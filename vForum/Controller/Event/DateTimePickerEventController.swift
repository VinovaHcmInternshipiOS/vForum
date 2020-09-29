//
//  DateTimePickerEventController.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

extension DateTimePickerEvent {
    @objc func cancelBtnPressed(_ sender: UIButton) {
        closeVC()
    }
    
    @objc func saveBtnPressed(_ sender: UIButton) {
        guard let startDate = startDateTimePicker?.date, let endDate = endDateTimePicker?.date else {
            return
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
