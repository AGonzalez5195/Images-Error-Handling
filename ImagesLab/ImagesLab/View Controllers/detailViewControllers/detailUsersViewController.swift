//
//  detailUsersViewController.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/7/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class detailUsersViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var currentUser: userResults!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()
        loadImage()
        setCircleOutline()
    }
    
    private func loadImage() {
        let urlStr = currentUser.picture.large
        guard let url = URL(string: urlStr) else {return}
        DispatchQueue.global(qos: .userInitiated).async {
            do { let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.profileImage.image = image
                }
            } catch {fatalError()}
        }
    }
    
    
    private func setLabelText () {
        userLabel.text = currentUser.getFullName()
        dobLabel.text = "Age: \(currentUser.dob.age)"
        phoneNumberLabel.text =
        """
        Phone #: \(currentUser.phone)
        Cell #: \(currentUser.cell)
        """
        addressLabel.text = "\(currentUser.getLocation())"
    }
    
    private func setCircleOutline() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 4.0
    }
}

