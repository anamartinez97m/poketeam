//
//  PokemonController.swift
//  poketeam
//
//  Created by Ana on 3/4/22.
//

import Foundation

class PokemonController {
    let config = URLSessionConfiguration.default
    
    struct PokemonsResponse: Codable {
        let name: String
        let base_experience: Int
        let sprites: PokemonsSprite
    }
    
    struct PokemonsSprite: Codable {
        let other: PokemonsSpriteOther
    }
    
    struct PokemonsSpriteOther: Codable {
        let dream_world: PokemonsSpriteOtherDreamWorld
    }
    
    struct PokemonsSpriteOtherDreamWorld: Codable {
        let front_default: String
    }
    
    struct GenerationsResponse: Codable {
        let count: Int
        //let results: Dictionary<String>
    }

    func getPokemonsByName(name: String, callback: @escaping (PokemonsResponse) -> Void) {
        let session = URLSession(configuration: config)
        
        let urlStr = "https://pokeapi.co/api/v2/pokemon/" + name
        
        if let url = URL(string: urlStr) {
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                guard data != nil else {
                    if let err = error {
                        debugPrint("error al recuperar los datos: ")
                        debugPrint(err)
                        DispatchQueue.main.async {
                            print("error al recuperar los datos \(err.localizedDescription)")
                        }
                    } else {
                        DispatchQueue.main.async {
                            print("no hay datos")
                        }
                    }
                    return
                }
                do {
                    if let data = data {
                        let res = try JSONDecoder().decode(PokemonsResponse.self, from: data)
                        callback(res)
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
            
        } else {
            print("error al crear la url")
        }
    }
    
    func getPokemonsGenerations(callback: @escaping (Int) -> Void) {
        let session = URLSession(configuration: config)
        
        let urlStr = "https://pokeapi.co/api/v2/generation"
        
        if let url = URL(string: urlStr) {
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                guard data != nil else {
                    if let err = error {
                        debugPrint("error al recuperar los datos: ")
                        debugPrint(err)
                        DispatchQueue.main.async {
                            print("error al recuperar los datos \(err.localizedDescription)")
                        }
                    } else {
                        DispatchQueue.main.async {
                            print("no hay datos")
                        }
                    }
                    return
                }
                do {
                    if let data = data {
                        let res = try JSONDecoder().decode(GenerationsResponse.self, from: data)
                        print(res)
                        //self.generationsCount = res.count
                        callback(res.count)
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
            
        } else {
            print("error al crear la url")
        }
    }
}
