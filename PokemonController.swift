//
//  PokemonController.swift
//  poketeam
//
//  Created by Ana on 3/4/24.
//

import Foundation

class PokemonController {
    struct GeneralResponse: Decodable {
        let results: [Pokemon]
    }
    
    let config = URLSessionConfiguration.default
    
    func getAllPokemonsNames(callback: @escaping ([Pokemon]) -> Void) {
        let session = URLSession(configuration: config)
        
        let urlStr = "https://pokeapi.co/api/v2/pokemon/?limit=1200"
        
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
                        let res = try JSONDecoder().decode(GeneralResponse.self, from: data)
                        callback(res.results)
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

    func getPokemonsByName(name: String, callback: @escaping (Pokemon) -> Void) {
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
                        let res = try JSONDecoder().decode(Pokemon.self, from: data)
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
                        let res = try JSONDecoder().decode(Generations.self, from: data)
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
