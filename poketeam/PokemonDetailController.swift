//
//  PokemonDetail.swift
//  poketeam
//
//  Created by Ana on 24/4/22.
//

import UIKit
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
                print("in callback", response)
                self.pokemonImage = UIImage(named: response.sprites?.other.dream_world.front_default ?? "")
                // pokemonImageView.image = self.pokemonImage
                print(response.sprites?.other.dream_world.front_default)
            }
            pokemonImageView.image = pokemonImage
            pokemonNameTitle.text = pokemon.name
        }
    }
}
