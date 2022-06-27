//
//  PokeAvatar.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 27/06/2022.
//

import Foundation
import UIKit

class PokeAvatar: UITableViewCell {
    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    func updateCell(name: String?) {
        self.nameLbl.text = name
    }
}
