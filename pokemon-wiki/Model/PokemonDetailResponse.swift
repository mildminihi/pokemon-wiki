//
//  PokemonDetailResponse.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 27/4/2567 BE.
//
import Foundation

struct PokemonDetailResponse: Codable {
    let id: Int
    let locationAreaEncounters: String
    let name: String
    let sprites: Sprites
    let stats: [StatElement]
    let types: [TypeElement]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case id
        case locationAreaEncounters = "location_area_encounters"
        case name, sprites, stats, types, weight
    }
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault, backFemale, backShiny, backShinyFemale: String?
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - StatElement
struct StatElement: Codable {
    let baseStat, effort: Int
    let stat: TypeClass

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeClass
struct TypeClass: Codable {
    let name: String
    let url: String
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: TypeClass
}

