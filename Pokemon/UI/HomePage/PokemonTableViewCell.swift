//
//  PokemonItem.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 24/06/2022.
//

import Foundation
import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var indexLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    func updateLbl(index: Int, name: String) {
        print("haha22222", index)
        self.indexLbl.text = String(index)
        self.nameLbl.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.indexLbl.text = ""
        self.nameLbl.text = ""
    }
}
