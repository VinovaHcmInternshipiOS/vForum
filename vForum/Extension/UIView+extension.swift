//
//  UIView+extension.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/24/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func dropShadow(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: 1, height: -1)
      layer.shadowRadius = 3

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
