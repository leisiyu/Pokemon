//
//  ModelPokemon.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 26/06/2022.
//

import Foundation
import SwiftyJSON

public final class ModelPokemon: Mappable {
    public let id: String
    public let name: String
    public let baseExperience: Int
    public let height: Int
    public let isDefault: Bool
    public let order: Int
    public let weight: Int
    public let images: [String: JSON]
    
    
    
    
    public required init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.baseExperience = json["base_experience"].intValue
        self.height = json["height"].intValue
        self.isDefault = json["is_default"].boolValue
        self.order = json["order"].intValue
        self.weight = json["weight"].intValue
        self.images = json["sprites"].dictionaryValue
    }
}
