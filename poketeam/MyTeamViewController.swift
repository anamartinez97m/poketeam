//
//  MyTeamViewController.swift
//  poketeam
//
//  Created by Ana on 2/4/22.
//

import UIKit

class MyTeamViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    let myTeam = ["😂","🤪","🧐","🤯","😇"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = myTeam.count

    }
}
