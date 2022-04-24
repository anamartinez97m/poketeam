//
//  Pokemon.swift
//  poketeam
//
//  Created by Ana on 18/4/22.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let base_experience: Int?
    let sprites: PokemonsSprite?
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

struct Generations: Codable {
    let count: Int
}
