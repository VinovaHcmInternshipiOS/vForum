//
//  DetailEventController.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

extension DetailEventController {
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
}
