//
//  NetworkManager.swift
//  Pokemon
//
//  Created by Qianwen Lyu on 25/06/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


public final class NetworkManager: NSObject {
    public static let shared = NetworkManager()
    
    private override init() {
        super.init()
    }
    
    func mapArray<T: Mappable>(data: JSON) throws -> [T]{
        var obj: [T] = []
        for item in data.arrayValue {
            obj.append(T.init(item)!)
        }
        return obj
    }
    
    func mapObject<T: Mappable>(data: JSON) throws -> T {
        guard let obj = T.init(data) else {
            throw data.error!
        }
        return obj
    }
}

extension NetworkManager {
    
    func getPokemonList(
        success: @escaping ([ModelPokemonItem]) -> Void,
        failure: @escaping () -> Void
    ) {
        AF.request(PokemonAPI.pokemonList.rawValue).responseJSON { [self] response in
            
            switch response.result {
            case let .success(data):
                do {
                    let json = JSON(data)
                    let pokemonListData: [ModelPokemonItem] = try mapArray(data: json["results"])
                    
                    success(pokemonListData)
                } catch {
                    print("fail")
                }
                
            case let .failure(apiError):
                print(apiError.localizedDescription)
            }
           
        }
    }
    
    func getPokemonData(
        url: String,
        success: @escaping (ModelPokemon) -> Void,
        failure: @escaping () -> Void
    ) {
        AF.request(url).responseJSON { [self] response in
            switch response.result {
            case let .success(data):
                do {
                    let json = JSON(data)
                    let pokemonData: ModelPokemon = try mapObject(data: json)
                    success(pokemonData)
                } catch {
                    print("fail")
                }
            case let .failure(apiError):
                print(apiError.localizedDescription)
            }
        }
    }
    
}
