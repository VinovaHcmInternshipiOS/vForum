//
//  DetailEvent.swift
//  vForum
//
//  Created by Phúc Lý on 9/23/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class DetailEvent: UIViewController {
    
    var cancelBtn: UIButton?
    var saveBtn: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initializeCancelBtn(&cancelBtn)
        initializeSaveBtn(&saveBtn)
    }
    
    func initializeCancelBtn(_ cancelBtn: inout UIButton?) {
        cancelBtn = UIButton()
        guard let cancelBtn = cancelBtn else {
            return
        }
        view.addSubview(cancelBtn)
        
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cancelBtn.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        cancelBtn.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.2).isActive = true
        cancelBtn.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.06).isActive = true
        
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.setTitleColor(.red, for: .normal)
        cancelBtn.titleLabel?.font = UIFont(name: "Futura", size: self.view.bounds.height * 0.06 * 0.4)
        cancelBtn.addTarget(self, action: #selector(cancelBtnPressed(_:)), for: .touchUpInside)
    }
    
    func initializeSaveBtn(_ saveBtn: inout UIButton?) {
        saveBtn = UIButton()
        guard let saveBtn = saveBtn else {
            return
        }
        view.addSubview(saveBtn)
        
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        saveBtn.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        saveBtn.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.2).isActive = true
        saveBtn.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.06).isActive = true
        
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(UIColor(red: 39/255, green: 93/255, blue: 173/255, alpha: 1.0), for: .normal)
        saveBtn.titleLabel?.font = UIFont(name: "Futura", size: self.view.bounds.height * 0.06 * 0.4)
        saveBtn.addTarget(self, action: #selector(saveBtnPressed(_:)), for: .touchUpInside)
    }
    
    @objc func cancelBtnPressed(_ sender: UIButton) {
        closeVC()
    }
    
    @objc func saveBtnPressed(_ sender: UIButton) {
        closeVC()
    }
    
    func closeVC() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
