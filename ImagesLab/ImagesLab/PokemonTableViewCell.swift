//
//  PokemonTableViewCell.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/6/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonCardImage: UIImageView!
    
    @IBOutlet weak var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
