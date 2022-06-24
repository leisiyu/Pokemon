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
    
    private var pokemonList: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pokemonTableView.register(PokemonItem.self, forCellReuseIdentifier: "pokemon_item")
        
    }
}

extension HomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon_item", for: indexPath)
        
        // to du: update
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
}


