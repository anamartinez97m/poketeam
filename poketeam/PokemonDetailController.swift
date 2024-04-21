//
//  PokemonDetail.swift
//  poketeam
//
//  Created by Ana on 24/4/24.
//

import UIKit
import SwiftSVG

class PokemonDetailController: UIViewController {
    @IBOutlet weak var pokemonNameTitle: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    let pokemonController = PokemonController()
    var pokemonImage: UIImage!
    
    var pokemon: Pokemon? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        if let pokemon = pokemon, let pokemonImageView = pokemonImageView {
            pokemonController.getPokemonsByName(name: pokemon.name) { [self]
                response in
                // print("in callback", response)
                // self.pokemonImage = UIImage(named: response.sprites?.other.dream_world.front_default ?? "")
                // pokemonImageView.image = self.pokemonImage
                // print(response.sprites?.other.dream_world.front_default)
                guard let svgURLString = response.sprites?.other.dream_world.front_default,
                      let svgURL = URL(string: svgURLString) else {
                    print("Invalid SVG URL")
                    return
                }
                
                // Load SVG from URL
                do {
                    let svgData = try Data(contentsOf: svgURL)
                    // Convert SVG to UIImage
                    let svgImage = UIImage(data: svgData)
                    DispatchQueue.main.async {
                        pokemonImageView.image = svgImage
                    }
                } catch {
                    print("Error loading SVG image: ", error)
                }
            }
            // pokemonImageView.image = pokemonImage
            pokemonNameTitle.text = pokemon.name
        }
    }
}
