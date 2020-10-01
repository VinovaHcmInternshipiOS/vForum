//
//  AlertMessage.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/30/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

class AlertView: NSObject {
    var okButton: (()->Void)? = nil
    class func showAlert(view: UIViewController , message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
}
