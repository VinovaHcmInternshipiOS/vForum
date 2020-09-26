//
//  SettingViewController.swift
//  UiForum
//
//  Created by vinova on 25/09/2020.
//

import UIKit

class SettingViewController: UIViewController {
    let settings = ["Account Information","Log out"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Setting"
        tableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "settingCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = view.bounds.height * 0.05
        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }

   private func logout() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! SettingTableViewCell
        if indexPath.row == settings.count - 1 {
            cell.img.image = UIImage(named: "left")
            cell.optionalLbl.textColor = .systemRed
        }
        cell.optionalLbl.text = settings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == settings.count - 1  {
            logout()
        }
    }
}
