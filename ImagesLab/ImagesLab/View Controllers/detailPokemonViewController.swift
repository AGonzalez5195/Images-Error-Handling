
//
//  detailPokemonViewController.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/7/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class detailPokemonViewController: UIViewController {

    var pokemonCard: Card!
    
    @IBOutlet weak var weaknessLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()
        setCardImage()
    }
    
    private func setLabelText() {
       nameLabel.text = pokemonCard.name
        weaknessLabel.text = pokemonCard.displayPokemonWeakness(card: pokemonCard)
        setLabel.text = "\(pokemonCard.set) Set"
        typeLabel.text = "\(pokemonCard.types[0]) type"
    }
    
    private func setCardImage() {
        ImageHelper.shared.fetchImage(urlString: pokemonCard.imageURLHiRes) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    self.cardImage.image = imageFromOnline
                }
            }
        }
    }
}
