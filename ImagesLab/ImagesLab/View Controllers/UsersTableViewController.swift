//
//  UsersTableViewController.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/7/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    
    var users = [userResults]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = users[indexPath.row]
        let userCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UsersTableViewCell
        userCell.nameLabel?.text = currentUser.getFullName()
        userCell.ageLabel?.text = "Age: \(currentUser.dob.age)"
        userCell.phoneLabel?.text = "Cell: \(currentUser.cell)"
        ImageHelper.shared.fetchImage(urlString: currentUser.picture.large) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                  userCell.profilePicture.image = imageFromOnline
                }
            }
        }
        
        userCell.profilePicture.layer.cornerRadius = userCell.profilePicture.frame.size.width/2
        userCell.profilePicture.clipsToBounds = true
        userCell.profilePicture.layer.borderColor = UIColor.black.cgColor
        userCell.profilePicture.layer.borderWidth = 3.0
        return userCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    private func loadData(){
        usersModel.getUserData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let userData):
                    self.users = userData
                   self.users = sortByNameAscending(userArrayToSort: self.users)
                }
            }
        }
    }
}
