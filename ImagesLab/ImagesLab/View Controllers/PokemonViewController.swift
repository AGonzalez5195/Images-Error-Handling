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
    
    var pokemonCard = [Card]() {
        didSet{
            tableView.reloadData()
        }
    }
    
//    private func loadData() {
//        PokemonAPI.shared.fetchDataForAnyURL(url: "https://api.pokemontcg.io/v1/cards?contains=types")  { (result) in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let data):
//                do {
//                    self.pokemonCard = try Pokemon.getPokemon(from: data)
//                    DispatchQueue.main.sync {
//                        self.tableView.reloadData()
//                    }
//                } catch {fatalError("\(error)")}
//            }
//        }
//    }
    
    private func loadData(){
        Pokemon.getPokemonCardData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let pokemonData):
                    self.pokemonCard = pokemonData
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifer = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifer {
        case "segueToDetail":
            guard let destVC = segue.destination as? detailPokemonViewController else { fatalError("Unexpected segue VC") }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { fatalError("No row selected") }
            let currentPokemonCard = pokemonCard[selectedIndexPath.row]
            destVC.pokemonCard = currentPokemonCard
        default:
            fatalError("unexpected segue identifier")
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
        pokemonCell.weaknessesLabel.text = currentPokemonCard.weaknesses?[0].type
        
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
