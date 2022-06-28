//
//  HomePage.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 24/06/2022.
//

import Foundation
import UIKit

class HomePage: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    private var pokemonList: [ModelPokemonItem] = []
    private var nextUrl: String = ""
    private var isLoading = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.searchBar.delegate = self
        
        // register cells
        self.pokemonTableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemon_tableView_cell")
        self.pokemonTableView.register(UINib(nibName: "PokemonTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "pokemon_tableView_header")
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
        
        self.loadData()
    }
    
    func loadData() {
        self.isLoading = true
        NetworkManager.shared.getPokemonList(nextUrl: self.nextUrl){ data, nextUrl in
            self.pokemonList = self.pokemonList + data
            self.nextUrl = nextUrl
            self.isLoading = false
            self.pokemonTableView.reloadData()
        } failure: {
            self.isLoading = false
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
        let cellData = self.pokemonList[indexPath.row]
        cell.updateLbl(index: cellData.idx, name: cellData.name, pokeUrl: cellData.pokemonUrl)
        cell.tapCallback = {
            let storyBoard = UIStoryboard(name: "PokemonPage", bundle: nil)
            let pokePageVC = storyBoard.instantiateViewController(withIdentifier: "pokemon_page") as! PokemonPage
            pokePageVC.updateParams(url: cellData.pokemonUrl)
            self.present(pokePageVC, animated: true)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "pokemon_tableView_header") as! PokemonTableViewHeader
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let scrollViewHeight = bounds.size.height
        let currentOffset = offset.y + scrollViewHeight - inset.bottom
        let maximumOffset = size.height
        
        var isNeedLoadMore = false
        // contents' height <= tableview's height
        if (scrollViewHeight >= maximumOffset) {
            if !self.nextUrl.isEmpty {
                isNeedLoadMore = true
            }
        } else {
            //
            let space = currentOffset - maximumOffset
            if (space < 20 && !self.nextUrl.isEmpty) {
                isNeedLoadMore = true
            }
        }
        
        if (!self.isLoading && isNeedLoadMore) {
            self.loadData()
        }
    }
}

extension HomePage: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        
        if let searchText = self.searchBar.text {
            let searchUrl = String(format: "%@/%@", PokemonAPI.pokemonList.rawValue, searchText.trimmingCharacters(in: .whitespacesAndNewlines)).lowercased()
            print(searchUrl)
            
            let storyBoard = UIStoryboard(name: "PokemonPage", bundle: nil)
            let pokePageVC = storyBoard.instantiateViewController(withIdentifier: "pokemon_page") as! PokemonPage
            pokePageVC.updateParams(url: searchUrl)
            self.present(pokePageVC, animated: true)
        }
        

    }
}


