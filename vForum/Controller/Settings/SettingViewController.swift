//
//  SettingViewController.swift
//  UiForum
//
//  Created by vinova on 25/09/2020.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    let optionals = ["Log out"]
    
    @IBOutlet weak var avatarUImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var displaynameLbl: UILabel!
    @IBOutlet weak var roleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Setting"
        setUpItem()
    }

   private func logout() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setUpItem(){
        tableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "settingCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
    }

}
//MARK: - Setup Tableview 
extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! SettingTableViewCell
        if indexPath.row == optionals.count - 1 {
            cell.img.image = UIImage(named: "left")
            cell.optionalLbl.textColor = .systemRed
        }
        cell.optionalLbl.text = optionals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == optionals.count - 1  {
            logout()
        }
    }
}
