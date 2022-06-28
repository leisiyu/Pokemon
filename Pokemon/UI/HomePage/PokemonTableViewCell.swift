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
    
    var url = ""
    var tapCallback: () -> () = {}
    
    
    func updateLbl(index: Int, name: String, pokeUrl: String) {
        self.indexLbl.text = String(format: "#%d", index)
        self.nameLbl.text = name
        self.url = pokeUrl
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(sender: ))))
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            tapCallback()
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.indexLbl.text = ""
        self.nameLbl.text = ""
    }
}
