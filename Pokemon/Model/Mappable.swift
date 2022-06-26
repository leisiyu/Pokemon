//
//  Mappable.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 26/06/2022.
//

import Foundation
import SwiftyJSON

protocol Mappable {
    init?(_ json: JSON)
}
