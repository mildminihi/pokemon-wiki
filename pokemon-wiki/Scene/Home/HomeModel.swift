//
//  HomeModel.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation

enum HomeModel {
    
    enum FetchPokemonList {
        struct Response {
            let pokemonList: [PokemonCellViewModel]
        }
        struct ViewModel {
            let pokemonList: [PokemonCellViewModel]
        }
    }
}
