//
//  PokeAvatar.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 27/06/2022.
//

import Foundation
import UIKit
import Kingfisher

class PokeAvatar: UITableViewCell {
    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    func updateCell(data: ModelPokemon?) {
        if let pokeData = data {
            self.nameLbl.text = pokeData.name
            let url = URL(string: pokeData.images["front_default"]?.stringValue ?? "")
            self.avatarImgView.kf.setImage(with: url)
        } else {
            print("error")
        }
        
    }
}
