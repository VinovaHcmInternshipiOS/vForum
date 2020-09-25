//
//  SettingViewController.swift
//  UiForum
//
//  Created by vinova on 25/09/2020.
//

import UIKit

class SettingViewController: UIViewController {
    let optionals = ["Optional","Optional","Optional","Optional","Optional","Optional","Log out"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Setting"
        tableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "settingCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }

   private func logout() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

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
