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
    
    enum ShowAlert {
        struct Response {
            let title: String
            let message: String
        }
        
        struct ViewModel {
            let title: String
            let message: String
        }
    }
    
    enum ShowSearchSuggestion {
        struct Request {
            let text: String
        }
        
        struct Response {
            let text: String?
        }
        
        struct ViewModel {
            let text: String?
        }
    }
}
