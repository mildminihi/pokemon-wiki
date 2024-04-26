//
//  HomeInteractor.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation

protocol HomeInteractorInterface {
    func fetchPokemonList()
}

class HomeInteractor: HomeInteractorInterface {
    var presenter: HomePresenterInterface?
    var worker: HomeWorkerInterface?
    
    func fetchPokemonList() {
        worker?.getPokemonList(offset: 0, completion: { response in
            switch response {
            case .success(let data):
                let response = data.results.map {PokemonCellViewModel(imageUrl: $0.url, pokemonName: $0.name)}
                self.presenter?.presentPokemonList(response: HomeModel.FetchPokemonList.Response(pokemonList: response))
            case .failure(let failure):
                print("error")
            }
        })
    }
}
