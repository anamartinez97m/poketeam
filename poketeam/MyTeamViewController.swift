//
//  MyTeamViewController.swift
//  poketeam
//
//  Created by Ana on 2/4/22.
//

import UIKit

class MyTeamViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var pageOutlet: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var myTeam = ["😂","🤪","🧐","🤯"]
    var frame = CGRect.zero
    var slides: [MyTeamSlide] = []
    // let pokemonController: PokemonController = PokemonController()
    
    /*struct Pokemon: Codable {
        let image: UIImage
        let name: String
        let description: String
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        getPokemonsByName(name: "eevee") { [self]
            response in
            print("in callback", response)
            self.myTeam.append(response.name)
            slides = createSlides(response: response)
            setupScreens(slides: slides)
        }

        //slides = createSlides()
        // setupScreens(slides: slides)
        
        pageOutlet.numberOfPages = slides.count
        pageOutlet.currentPage = 0
        view.bringSubviewToFront(pageOutlet)
    }
    
    func createSlides(response: PokemonsResponse) -> [MyTeamSlide] {
        for index in 0 ..< myTeam.count {
            let slide: MyTeamSlide = Bundle.main.loadNibNamed("MyTeamSlide", owner: self, options: nil)?.first as! MyTeamSlide
            slide.pokemonImage.image = UIImage(named: response.sprites.other.dream_world.front_default)
            slide.pokemonName.text = myTeam[index]
            slide.pokemonDescription.text = "Descripcion"
            
            slides.append(slide)
        }
        
        return slides
    }
    
    func setupScreens(slides: [MyTeamSlide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageOutlet.currentPage = Int(pageIndex)
    }

    
    
    
    let config = URLSessionConfiguration.default
    
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

    func getPokemonsByName(name: String, callback: @escaping (PokemonsResponse) -> Void) {
        let session = URLSession(configuration: config)
        
        let urlStr = "https://pokeapi.co/api/v2/pokemon/" + name
        
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
                        let res = try JSONDecoder().decode(PokemonsResponse.self, from: data)
                        callback(res)
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
}
