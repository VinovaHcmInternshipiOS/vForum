//
//  CreationEventController.swift
//  vForum
//
//  Created by Phúc Lý on 9/25/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import UIKit

extension CreationEventController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    @objc func moveToDateTimePicker(sender: UITapGestureRecognizer) {
        let datePicker = DateTimePickerEvent()
        datePicker.chooseDateTime = { startDate, endDate in
//            let current = Calendar.current
            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy 'T' HH:mm"
            
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            self.startDateLbl?.text = dateFormatter.string(from: startDate)
            self.endDateLbl?.text = dateFormatter.string(from: endDate)
            
        }
        present(datePicker, animated: true, completion: nil)
    }
    
    @objc func saveBarBtnPressed(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextField?.text, let description = descriptionTextField?.text, let startDate = startDateLbl?.text, let endDate = endDateLbl?.text, let banner = banner else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        guard let start = dateFormatter.date(from: startDate), let end = dateFormatter.date(from: endDate) else {
            return
        }
        
        EventManager.shared.createEvent(title: title, description: description, startDate: start, endDate: end, banner: banner)
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
        }
    }

    
}
