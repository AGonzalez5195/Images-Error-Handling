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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemonCards = [Card]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var filteredPokemonCards: [Card] {
        get {
            guard let searchString = searchString else { return pokemonCards }
            guard searchString != ""  else { return pokemonCards }
            return Card.getFilteredCards(arr: pokemonCards, searchString: searchString)
        }
    }
    
    var searchString: String? = nil { didSet { self.tableView.reloadData()} }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifer = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifer {
        case "segueToDetail":
            guard let destVC = segue.destination as? detailPokemonViewController else { fatalError("Unexpected segue VC") }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { fatalError("No row selected") }
            let currentPokemonCard = filteredPokemonCards[selectedIndexPath.row]
            destVC.pokemonCard = currentPokemonCard
        default:
            fatalError("unexpected segue identifier")
        }
    }
    

    private func loadData(){
        Pokemon.getPokemonCardData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let pokemonData):
                    self.pokemonCards = pokemonData
                    self.pokemonCards = Card.sortByNameAscending(arr: self.pokemonCards)
                }
            }
        }
    }
    
    private func configureDelegateDataSources(){
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegateDataSources()
        loadData()
    }
}


extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemonCards.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPokemonCard = filteredPokemonCards[indexPath.row]
        let pokemonCell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        
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
        return 500
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
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
