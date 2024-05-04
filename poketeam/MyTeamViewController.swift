//
//  MyTeamViewController.swift
//  poketeam
//
//  Created by Ana on 2/4/24.
//

import UIKit

class MyTeamViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var pageOutlet: UIPageControl!
    //@IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var myTeamSlide: MyTeamSlide!
    
    var pokemonController = PokemonController()
    
    var myTeam = ["😂","🤪","🧐","🤯"]
    var frame = CGRect.zero
    var slides: [MyTeamSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTeamSlide = MyTeamSlide()
        //scrollView.delegate = self
        
        pokemonController.getPokemonsByName(name: "eevee") { [self]
            response in
            //print("in callback", response)
            self.myTeam.append(response.name)
            slides = createSlides(response: response)
            setupScreens(slides: slides)
        }

        // slides = createSlides()
        // setupScreens(slides: slides)
        
        pageOutlet.numberOfPages = slides.count
        pageOutlet.currentPage = 0
        view.bringSubviewToFront(pageOutlet)
    }
    
    func createSlides(response: Pokemon) -> [MyTeamSlide] {
        //for index in 0 ..< myTeam.count {
            //let slide: MyTeamSlide = Bundle.main.loadNibNamed("MyTeamSlide", owner: self, options: nil)?.first as! MyTeamSlide
            //slide.pokemonImage.image = UIImage(named: response?.sprites.other.dream_world.front_default)
            //myTeamSlide.pokemonName.text = myTeam[index]
            //myTeamSlide.pokemonDescription.text = "Description"
            //slide.setPokemonDescription("Description")
            //myTeamSlide.setPokemonDescription("Description")
            //slides.append(myTeamSlide)
        //}
        
        return slides
    }
    
    func setupScreens(slides: [MyTeamSlide]) {
        //scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        //scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        //scrollView.isPagingEnabled = true
        
        //for i in 0 ..< slides.count {
        //    slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
         //   scrollView.addSubview(slides[i])
        //}
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageOutlet.currentPage = Int(pageIndex)
    }

    struct PokemonsResponse: Codable {
        let name: String
        let base_experience: Int
        let sprites: PokemonsSprite
    }
    
    struct PokemonsSprite: Codable {
        let other: PokemonsSpriteOther
    }
    
    struct PokemonsSpriteOther: Codable {
        let dream_world: PokemonsSpriteOtherDreamWorld
    }
    
    struct PokemonsSpriteOtherDreamWorld: Codable {
        let front_default: String
    }
}

