//
//  PokemonAttributeItem.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 27/06/2022.
//

import Foundation
import UIKit

class PokemonAttributeItem: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAttribute: UILabel!
    
    func updateCell(name: String, attribute: String) {
        self.lblName.text = name
        self.lblAttribute.text = attribute
    }
    
}
