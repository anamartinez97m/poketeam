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
        let baseExperience: Int
    }
    

    func getPokemonsByName(name: String, callback: @escaping (PokemonsResponse) -> Void) {
        let session = URLSession(configuration: config)
        
        let urlStr = "https://pokeapi.co/api/v2/pokemon/" + name
        
        print(urlStr)
        
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
                        print(res)
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
}
