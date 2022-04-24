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
        print(pokemon)
        if let pokemon = pokemon, let pokemonImageView = pokemonImageView {
            pokemonImageView.image = UIImage(named: pokemon.name)
            pokemonNameTitle.text = pokemon.name
        }
    }
}
