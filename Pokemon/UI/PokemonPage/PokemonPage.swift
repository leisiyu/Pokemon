//
//  PokemonPage.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 26/06/2022.
//

import Foundation
import UIKit


class PokemonPage: UIViewController {
    var url: String = ""
    
    @IBOutlet weak var pokeTableView: UITableView!
    
    enum SectionType: Int {
        case avatar = 0
        case attributes
    }
    
    enum AttributesType {
//        case pokeType
        case height
        case weight
        case order
        case isDefault
        case baseExperience
    }
    
    var sectionList: [SectionType] = [
        .avatar,
        .attributes
    ]
    var attributesList: [AttributesType] = [
        .order,
        .height,
        .weight,
        .baseExperience,
        .isDefault
    ]
    var pokeData: ModelPokemon?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // register cells
        self.pokeTableView.register(UINib(nibName: "PokemonAttributeItem", bundle: nil), forCellReuseIdentifier: "poke_attr_item")
        self.pokeTableView.register(UINib(nibName: "PokeAvatar", bundle: nil), forCellReuseIdentifier: "poke_avatar")
        
        self.pokeTableView.dataSource = self
        self.pokeTableView.delegate = self
        
        if !self.url.isEmpty {
            NetworkManager.shared.getPokemonData(url: self.url) {pokeData in
                self.pokeData = pokeData
                self.pokeTableView.reloadData()
            } failure: {
                print("2222")
            }

        } else {
            print("error")
        }
        
    }
    
    func updateParams(url: String) {
        self.url = url
    }
}

extension PokemonPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SectionType.avatar.rawValue {
            return 1
        } else {
            return attributesList.count
        }
//        return self.attributesList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionList.count
//        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SectionType.avatar.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "poke_avatar", for: indexPath) as! PokeAvatar
            
            cell.updateCell(data: self.pokeData)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "poke_attr_item", for: indexPath) as! PokemonAttributeItem
            
            var name = ""
            var attr = ""
            
            switch self.attributesList[indexPath.row] {
            case .weight:
                name = "Weight:"
                attr = String(self.pokeData?.weight ?? 0)
            case .height:
                name = "Height:"
                attr = String(self.pokeData?.height ?? 0)
            case .order:
                name = "Order:"
                attr = String(self.pokeData?.order ?? 0)
            case .isDefault:
                name = "IsDefault:"
                if let isDefault = self.pokeData?.isDefault {
                    attr = isDefault ? "yes" : "no"
                } else {
                    attr = "no"
                }
            case .baseExperience:
                name = "Base Experience:"
                attr = String(self.pokeData?.baseExperience ?? 0)
            }
            
            cell.updateCell(name: name, attribute: attr)
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == SectionType.avatar.rawValue {
            return 145
        } else {
            return 45
        }
    }
    
}
