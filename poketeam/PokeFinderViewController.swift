//
//  PokeFinderViewController.swift
//  poketeam
//
//  Created by Ana on 18/4/24.
//

import UIKit

class PokeFinderViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var pokemonController = PokemonController()
    
    var pokemons: [Pokemon] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPokemons: [Pokemon] = []
    var pokemonToView: Pokemon!
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonController.getAllPokemonsNames() { [self]
            response in
            self.pokemons.append(contentsOf: response)
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokemons"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchTableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if let indexPath = searchTableView.indexPathForSelectedRow {
          searchTableView.deselectRow(at: indexPath, animated: true)
      }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowDetailSegue",
            let indexPath = searchTableView.indexPathForSelectedRow,
            let pokemonDetailController = segue.destination as? PokemonDetailController
            else {
                return
        }
      
        let pokemon: Pokemon
        if isFiltering {
            pokemon = filteredPokemons[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        
        pokemonDetailController.pokemon = pokemon
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPokemons.count
        }
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeFinderCell", for: indexPath)
        let pokemon: Pokemon
        if isFiltering {
            pokemon = filteredPokemons[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        cell.textLabel?.text = pokemon.name
        return cell
    }

    
    func filterContentForSearchText(_ searchText: String) {
        filteredPokemons = pokemons.filter{(pokemon: Pokemon) -> Bool in
            return pokemon.name.lowercased().contains(searchText.lowercased())
        }
        searchTableView.reloadData()
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }

}
