//
//  HomePage.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 24/06/2022.
//

import Foundation
import UIKit

class HomePage: UIViewController {
    @IBOutlet weak var pokemonTableView: UITableView!
    
    private var pokemonList: [ModelPokemonItem] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pokemonTableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemon_tableView_cell")
        self.pokemonTableView.register(UINib(nibName: "PokemonTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "pokemon_tableView_header")
        
        NetworkManager.shared.getPokemonList { data in
            self.pokemonList = self.pokemonList + data
            print(self.pokemonList.count)
            self.pokemonTableView.reloadData()
        } failure: {
            print("faillllllll")
        }

    }

}

extension HomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon_tableView_cell", for: indexPath) as! PokemonTableViewCell
        
        // to du: update
        cell.updateLbl(index: indexPath.row, name: self.pokemonList[indexPath.row].name)
        
        // to do: tap
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "pokemon_tableView_header") as! PokemonTableViewHeader
        
        return header
    }
}


