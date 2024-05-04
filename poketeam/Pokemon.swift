//
//  Pokemon.swift
//  poketeam
//
//  Created by Ana on 18/4/24.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let base_experience: Int?
    let sprites: PokemonsSprite?
    let types: [PokemonTypes]?
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

struct PokemonTypes: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
    let url: String
}
