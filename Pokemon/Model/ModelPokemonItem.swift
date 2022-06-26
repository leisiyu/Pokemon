//
//  PokemonItem.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 25/06/2022.
//

import Foundation
import SwiftyJSON

public final class ModelPokemonItem: Mappable {
    public let name: String
    public let pokemonUrl: String
    
    public required init(_ json: JSON) {
        self.name = json["name"].stringValue
        self.pokemonUrl = json["url"].stringValue
        
    }
}
