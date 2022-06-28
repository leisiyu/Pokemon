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
    @IBOutlet weak var frontBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!

    var pokeData:ModelPokemon?
    
    func updateCell(data: ModelPokemon?) {
        if let pokeData = data {
            self.pokeData = pokeData
            self.nameLbl.text = pokeData.name
            let urlFront = pokeData.images["front_default"]?.stringValue ?? ""
            
            self.avatarImgView.kf.setImage(with: URL(string: urlFront))
        } else {
            print("error")
        }
        
    }
    
    @IBAction func leftBtnTapped(_ sender: Any) {
        if let pokeData = self.pokeData {
            let urlFront = pokeData.images["front_default"]?.stringValue ?? ""
            self.avatarImgView.kf.setImage(with: URL(string: urlFront))
        }
    }

    @IBAction func rightBtnTapped(_ sender: Any) {
        if let pokeData = self.pokeData {
            let urlBack = pokeData.images["back_default"]?.stringValue ?? ""
            self.avatarImgView.kf.setImage(with: URL(string: urlBack))
        }
    }
}
