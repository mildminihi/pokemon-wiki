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
        
        struct PokemonListViewModel {
            let pokemonName: String
            let urlDetail: String
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
    }
    
    enum SelectPokemon {
        struct Request {
            let pokemonName: String
        }
        
        struct Response {
            let urlString: String
        }
        
        struct ViewModel {
            let urlString: String
        }
    }
}
