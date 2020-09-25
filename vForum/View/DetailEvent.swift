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
    
    enum SideDateTimeEvent {
        case right, left
    }
    var blueColor: UIColor? = UIColor(red: 39/255, green: 93/255, blue: 173/255, alpha: 1.0)

    var event: Event?
    var cancelBtn: UIButton?
    var saveBtn: UIButton?
    var bannerImgView: UIImageView?
    var titleLbl: UILabel?
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
    
    func drawLine(startPoint: CGPoint, endPoint: CGPoint, color: UIColor) {
        let bezier = UIBezierPath()
        bezier.move(to: startPoint)
        bezier.addLine(to: endPoint)
        
        let shape = CAShapeLayer()
        shape.path = bezier.cgPath
        shape.strokeColor = color.cgColor
        shape.lineWidth = UIDevice.current.userInterfaceIdiom == .pad ? 2.0 : 1.0
        self.view.layer.addSublayer(shape)
    }
    
    func initializeViews() {
        guard let event = event else {
            return
        }
        initializeBanner(&bannerImgView, event.banner)
        initializeTitleLbl(&titleLbl, event.title)
        initializeDescriptionTxtView(&descriptionTxtView, event.description)
        initializeDateTimeArea(&startStackView, &startDateLbl, &startTimeLbl, "From: ", side: .left)
        initializeDateTimeArea(&endStackView, &endDateLbl, &endTimeLbl, "End: ", side: .right)
        initializeRemindArea(&remindCell, &remindBtn)
        
        drawLine(startPoint: CGPoint(x: self.view.bounds.width * 0.05, y: self.view.bounds.height * 0.45), endPoint: CGPoint(x: self.view.bounds.width * 0.95, y: self.view.bounds.height * 0.45), color: UIColor.black)
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
        saveBtn.setTitleColor(blueColor, for: .normal)
        saveBtn.titleLabel?.font = UIFont(name: "Futura", size: self.view.bounds.height * 0.06 * 0.4)
        saveBtn.addTarget(self, action: #selector(saveBtnPressed(_:)), for: .touchUpInside)
    }
    
    func initializeBanner(_ banner: inout UIImageView?, _ bannerImgName: String) {
        banner = UIImageView(image: UIImage(named: bannerImgName))
        guard let banner = banner else {
            return
        }
        self.view.addSubview(banner)
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        banner.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.3).isActive = true
        banner.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height * 0.1).isActive = true
        banner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    func initializeTitleLbl(_ title: inout UILabel?, _ text: String) {
        title = UILabel()
        guard let title = title, let banner = bannerImgView else {
            return
        }
        self.view.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width * 0.1).isActive = true
        title.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.05).isActive = true
        title.topAnchor.constraint(equalTo: banner.bottomAnchor).isActive = true

        
        title.textColor = .black
        title.font = UIFont(name: "Futura", size: self.view.bounds.height * 0.05 * 0.9)
        title.text = text
        
        
    }
    
    
    func initializeDescriptionTxtView(_ descriptionTxtView: inout UITextView?, _ text: String) {
        descriptionTxtView = UITextView(frame: .zero)
        guard let descriptionTxtView = descriptionTxtView, let titleLbl = titleLbl else {
            return
        }
        self.view.addSubview(descriptionTxtView)
        
        descriptionTxtView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTxtView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width * 0.1).isActive = true
        descriptionTxtView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        descriptionTxtView.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.15).isActive = true
        descriptionTxtView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor).isActive = true
        
        descriptionTxtView.textColor = .black
        descriptionTxtView.font = UIFont(name: "Futura", size: self.view.bounds.height * 0.05 * 0.5)
        descriptionTxtView.text = text
    }
    
    func initializeDateTimeArea(_ stack: inout UIStackView?, _ dateLabel: inout UILabel?, _ timeLabel: inout UILabel?, _ textLbl: String, side: SideDateTimeEvent) {
        
        let width = self.view.bounds.width * 0.5
        let height = self.view.bounds.height * 0.15
        
        stack = UIStackView()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.textAlignment = .center
        label.text = textLbl
        dateLabel = UILabel()
        timeLabel = UILabel()
        
        
        guard let stack = stack, let descriptionTxtView = descriptionTxtView, let dateLabel = dateLabel, let timeLabel = timeLabel else {
            return
        }
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(timeLabel)
        stack.addArrangedSubview(dateLabel)
        view.addSubview(stack)
        
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.widthAnchor.constraint(equalToConstant: width).isActive = true
        stack.heightAnchor.constraint(equalToConstant: height).isActive = true
        stack.topAnchor.constraint(equalTo: descriptionTxtView.bottomAnchor).isActive = true
        if side == .left {
            stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        }
        else if side == .right {
            stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
        
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
        label.heightAnchor.constraint(equalToConstant: height * 0.2).isActive = true
        label.font = UIFont(name: "Futura", size: height * 0.15)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: height * 0.5).isActive = true
        timeLabel.font = UIFont(name: "Futura", size: height * 0.5)
        timeLabel.font = .boldSystemFont(ofSize: height * 0.5)
        timeLabel.textColor = blueColor
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: height * 0.3).isActive = true
        dateLabel.font = UIFont(name: "Futura", size: height * 0.3)
        dateLabel.font = .boldSystemFont(ofSize: height * 0.2)
        dateLabel.textColor = blueColor
        
        let _date = side == .left ? event?.startDate : event?.endDate
        guard let date = _date else {
            return
        }
        timeLabel.textAlignment = .center
        timeLabel.text = "\(event?.getHour(from: date) ?? 0) : \(event?.getMinute(from: date) ?? 0)"
        dateLabel.textAlignment = .center
        dateLabel.text = event?.getDate(from: date, format: "dd-MM-yyyy")
        
    }
    
    func initializeRemindArea(_ cell: inout UITableViewCell?, _ button: inout UIButton?) {
        
        let width = self.view.bounds.width
        let height = self.view.bounds.height * 0.1
        
        cell = nil
        button = nil
        
        cell = UITableViewCell(style: .default, reuseIdentifier: "")
        button = UIButton()
        guard let cell = cell, let button = button else {
            return
        }
        cell.textLabel?.text = event?.repeated.toString()
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = UIColor(red: 171/255, green: 169/255, blue: 195/255, alpha: 1.0)
        cell.accessoryType = .disclosureIndicator
        
        view.addSubview(cell)
        view.addSubview(button)
        
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.widthAnchor.constraint(equalToConstant: width).isActive = true
        cell.heightAnchor.constraint(equalToConstant: height).isActive = true
        cell.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        cell.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.addTarget(self, action: #selector(remindBtnPressed(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func cancelBtnPressed(_ sender: UIButton) {
        closeVC()
    }
    
    @objc func saveBtnPressed(_ sender: UIButton) {
        closeVC()
    }
    
    @objc func remindBtnPressed(_ sender: UIButton) {
        let repeatPicker = RepeatPickerView()
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
