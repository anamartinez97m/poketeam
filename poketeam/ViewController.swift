//
//  ViewController.swift
//  poketeam
//
//  Created by Ana on 26/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    let sectionData = [
        "😂",
        "😳",
        "🤪",
        "🧐",
        "🤯",
        "😇"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource methods

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath)
        
        cell.backgroundView.text = sectionData[indexPath.section][indexPath.row]

        return cell
    }
}

