//
//  PokeFinderViewController.swift
//  poketeam
//
//  Created by Ana on 18/4/22.
//

import UIKit

class PokeFinderViewController: UIViewController {
    
    @IBOutlet weak var searchBar: PokeFinderViewController!
    
    let resultsFound: [Pokemon] = []
    
    struct Pokemon: Codable {
        let name: String
        let base_experience: Int
    }
 
    override func viewDidLoad() {
       super.viewDidLoad()
    }
    
    
}
