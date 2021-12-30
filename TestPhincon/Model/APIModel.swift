//
//  Pokemon.swift
//  TestPhincon
//
//  Created by Michael Tanakoman on 29/12/21.
//

import Foundation

struct Results: Codable{
    let results: [APIPokemon]
}

struct APIPokemon: Codable{
    let name: String
    let url: String
}

struct DetailPokemon: Codable{
    let sprites: DataImagePokemon
    let abilities: [Abilities]
    let moves: [Moves]
}

struct Abilities: Codable{
    let ability: AbilityName
}

struct AbilityName: Codable{
    let name: String
}

struct Moves: Codable{
    let move: MoveName
}

struct MoveName: Codable{
    let name: String
}

struct DataImagePokemon: Codable{
    let front_default: String
}
