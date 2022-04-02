//
//  ViewController.swift
//  poketeam
//
//  Created by Ana on 26/3/22.
//

import UIKit

class PokeListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let config = URLSessionConfiguration.default
    
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)
    private let itemsPerRow: CGFloat = 3
    
    private var generations: [String] = []
    
    //private var generationsCount: Int = 0
    
    let pokemons = [
        ["😂","😳","🤪","🧐","🤯","😇"],
        ["😂","😳","🤪","🧐","🤯","😇"],
        ["😂","😳","🤪","🧐","🤯","😇"]
    ]
    
    struct GenerationsResponse: Codable {
        let count: Int
        //let results: Dictionary<String>
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getPokemonsGenerations {
            response in
            //numberOfGenerations = response
            print("in callback", response)
            for elem in 0 ..< response {
                self.generations.append(elem.formatted())
            }
            print("generations despues del for: ", self.generations)
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("generations", generations)
        return generations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath)
            as! PokemonCollectionViewCell
        
        cell.pokemonLabel.text = pokemons[indexPath.section][indexPath.row]

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GenerationCell", for: indexPath) as! GenerationCollectionReusableView

        header.generationLabel.text = generations[indexPath.section]

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
      }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

