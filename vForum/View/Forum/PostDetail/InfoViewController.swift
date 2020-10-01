//
//  InfoViewController.swift
//  UiForum
//
//  Created by vinova on 30/09/2020.
//

import UIKit

class InfoViewController: UIViewController {

    var userInfo = [["Display Name","Gmail","Phone"],["Huỳnh Võ Hoàng Nam","huynhvohoangnam714@gmail.com","0325878766"]]
    var displayName = "Aland - Huỳnh Võ Hoàng Nam"
    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var displayNameLbl: UILabel!
    @IBOutlet weak var infoUserTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpItem()
    }
    
    private func setUpItem(){
        displayNameLbl.text = displayName
        infoUserTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "infoCell")
        infoUserTableView.separatorStyle = .none
        infoUserTableView.delegate = self
        infoUserTableView.dataSource = self
    }
}

extension InfoViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfo[0].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! InfoTableViewCell
        cell.titleLbl.text = userInfo[0][indexPath.row]
        cell.descriptionLbl.text = userInfo[1][indexPath.row]
        return cell
    }
    
    
}
