//
//  DetailModel.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 28/4/2567 BE.
//

import Foundation

enum DetailModel {
    enum GetPokemonDetail {
        struct Request {
            let urlString: String
        }
        
        struct Response {
            let pokemonDetail: PokemonDetailResponse
        }
        
        struct ViewModel {
            let model: PokemonDetailViewModel
        }
        
        struct PokemonDetailViewModel {
            let name: String
            let imageUrl: String
            let imageShinyUrl: String?
            let id: Int
            let type: [PokemonType]
            let weight: Int
            let height: Int
            let stat: [StatDetail]
        }
        
        struct StatDetail {
            let statName: String
            let value: Int
        }
    }
}
