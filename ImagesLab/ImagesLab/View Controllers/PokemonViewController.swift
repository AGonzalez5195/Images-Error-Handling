//
//  PokemonViewController.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/6/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonCard = [Card]() 
    
    private func loadData() {
        PokemonAPI.shared.fetchDataForAnyURL(url: "https://api.pokemontcg.io/v1/cards?contains=types")  { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    self.pokemonCard = try Pokemon.getPokemon(from: data)
                    DispatchQueue.main.sync {
                        self.tableView.reloadData()
                    }
                } catch {fatalError("\(error)")}
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
    }
}


extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPokemonCard = pokemonCard[indexPath.row]
        
        let pokemonCell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        pokemonCell.pokemonName.text = currentPokemonCard.name
        
        ImageHelper.shared.fetchImage(urlString: currentPokemonCard.imageURLHiRes) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    pokemonCell.pokemonCardImage.image = imageFromOnline
                }
            }
        }
        return pokemonCell
    }
}

extension PokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
