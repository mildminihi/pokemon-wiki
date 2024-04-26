//
//  PokemonResponse.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 26/4/2567 BE.
//

import Foundation

struct PokemonResponse: Codable {
    let count: Int?
    let next, previous: String?
    let results: [PokemonResult]
}

struct PokemonResult: Codable {
    let name: String
    let url: String
}

