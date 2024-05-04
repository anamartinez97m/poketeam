//
//  PokemonDetail.swift
//  poketeam
//
//  Created by Ana on 24/4/24.
//

import UIKit
import SVGKit

class PokemonDetailController: UIViewController {
    @IBOutlet weak var pokemonNameTitle: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonBaseExperienceLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    
    let pokemonController = PokemonController()
    var pokemonImage: UIImage!
    var pokemonResponse: Pokemon!
    
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
            pokemonController.getPokemonsByName(name: pokemon.name) { []
                response in
                guard let svgURLString = response.sprites?.other.dream_world.front_default,
                      let svgURL = URL(string: svgURLString) else {
                    print("Invalid SVG URL")
                    return
                }
                self.pokemonResponse = response
                
                // Load SVG from URL
                DispatchQueue.global(qos: .background).async {
                    do {
                        let svgData = try Data(contentsOf: svgURL)
                        let svgImage = SVGKImage(data: svgData)
                        
                        DispatchQueue.main.async {
                            pokemonImageView.image = svgImage?.uiImage
                        }
                    } catch {
                        print("Error loading SVG image: ", error)
                    }
                    
                    DispatchQueue.main.async {
                        if let pokemonResponse = self.pokemonResponse {
                            self.pokemonNameTitle.text = pokemonResponse.name.capitalized
                            self.pokemonBaseExperienceLabel.text =
                                pokemonResponse.base_experience != nil ? pokemonResponse.base_experience?.description : "-"
                            var types: String = ""
                            if let pokemonTypes = pokemonResponse.types {
                                pokemonTypes.forEach{elem in
                                    types.append(elem.type.name.capitalized + " ")
                                }
                                self.pokemonTypesLabel.text = types
                            }
                        }
                    }
                }
            }
        }
    }
}
