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
    let dispatchGroup = DispatchGroup()
    
    func fetchPokemonList() {
        dispatchGroup.enter()
        worker?.getPokemonList(offset: 0, completion: { response in
            switch response {
            case .success(let data):
                let response = data.results.map {PokemonCellViewModel(imageUrl: $0.url, pokemonName: $0.name)}
                self.getPokemonDetail(pokemonList: response)
            case .failure(let failure):
                print(failure)
            }
            DispatchQueue.main.async {
                self.dispatchGroup.leave()
            }
        })
    }
    
    private func getPokemonDetail(pokemonList: [PokemonCellViewModel]) {
        var pokemonDisplayList: [PokemonCellViewModel] = []
        for pokemon in pokemonList {
            dispatchGroup.enter()
            worker?.getPokemonDetail(url: pokemon.imageUrl, completion: { response in
                switch response {
                case .success(let data):
                    pokemonDisplayList.append(PokemonCellViewModel(imageUrl: data.sprites.frontDefault ?? "", pokemonName: data.name))
                case .failure(let failure):
                    print(failure)
                }
                DispatchQueue.main.async {
                    self.dispatchGroup.leave()
                }
            })
        }
        dispatchGroup.notify(queue: .main) {
            if pokemonList.count == pokemonDisplayList.count {
                self.presenter?.presentPokemonList(response: HomeModel.FetchPokemonList.Response(pokemonList: pokemonDisplayList))
            } else {
                print("error")
            }
        }
        
    }
}
