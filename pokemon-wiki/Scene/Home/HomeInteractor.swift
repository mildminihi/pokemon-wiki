//
//  HomeInteractor.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation

protocol HomeInteractorInterface {
    func fetchPokemonList()
    func loadMorePokemon()
    func searchSuggestion(request: HomeModel.ShowSearchSuggestion.Request)
    func clearSearch()
    func didSelectPokemon(request: HomeModel.SelectPokemon.Request)
}

protocol HomeInteractorDataStore {
    var pokemonDisplayTempList: [PokemonCellViewModel] { get set }
    var urlPokemonSelected: String? { get set }
}

class HomeInteractor: HomeInteractorInterface, HomeInteractorDataStore {
    var presenter: HomePresenterInterface?
    var worker: HomeWorkerInterface?
    let dispatchGroup = DispatchGroup()
    var pokemonDisplayTempList: [PokemonCellViewModel] = []
    var currentOffset = 0
    var allPokemonCount = 0
    var isSearch: Bool = false
    var pokemonDetailList: [HomeModel.FetchPokemonList.PokemonListViewModel] = []
    var urlPokemonSelected: String?
    
    func fetchPokemonList() {
        worker?.getAllPokemonList(offset: 0, completion: { response in
            switch response {
            case .success(let data):
                let response = data.results.map {HomeModel.FetchPokemonList.PokemonListViewModel(pokemonName: $0.name, urlDetail: $0.url)}
                self.allPokemonCount = data.count ?? 0
                self.pokemonDetailList = response
                self.loadMorePokemon()
            case .failure(let failure):
                self.presenter?.presentAlert(response: HomeModel.ShowAlert.Response(title: "Error", message: failure.errorMessage ?? ""))
            }
        })
    }
    
    func loadMorePokemon() {
        guard currentOffset + 13 < allPokemonCount else {
            presenter?.presentAlert(response: HomeModel.ShowAlert.Response(title: "Can't loadmore", message: "No more pokemon data"))
            return
        }
        let pokemonListDisplayRange = Array(pokemonDetailList[currentOffset...currentOffset + 13])
        currentOffset += 13
        getPokemonDetail(pokemonList: pokemonListDisplayRange)
    }
    
    private func getPokemonDetail(pokemonList: [HomeModel.FetchPokemonList.PokemonListViewModel]) {
        var pokemonDisplayList: [PokemonCellViewModel] = []
        for pokemon in pokemonList {
            dispatchGroup.enter()
            worker?.getPokemonDetail(url: pokemon.urlDetail, completion: { response in
                switch response {
                case .success(let data):
                    pokemonDisplayList.append(PokemonCellViewModel(imageUrl: data.sprites.frontDefault ?? "", pokemonName: data.name))
                case .failure(let failure):
                    self.presenter?.presentAlert(response: HomeModel.ShowAlert.Response(title: "Error", message: failure.errorMessage ?? ""))
                }
                DispatchQueue.main.async {
                    self.dispatchGroup.leave()
                }
            })
        }
        dispatchGroup.notify(queue: .main) {
            if pokemonList.count == pokemonDisplayList.count {
                if self.isSearch {
                    self.presenter?.presentPokemonList(response: HomeModel.FetchPokemonList.Response(pokemonList: pokemonDisplayList))
                } else {
                    self.pokemonDisplayTempList += pokemonDisplayList
                    self.presenter?.presentPokemonList(response: HomeModel.FetchPokemonList.Response(pokemonList: self.pokemonDisplayTempList))
                }
            } else {
                self.presenter?.presentAlert(response: HomeModel.ShowAlert.Response(title: "Error", message: "Please try again"))
            }
        }
        
    }
    
    func searchSuggestion(request: HomeModel.ShowSearchSuggestion.Request) {
        isSearch = true
        let suggestPokemon = pokemonDetailList.filter { pokemon in
            pokemon.pokemonName.contains(request.text)
        }
        self.pokemonDisplayTempList = []
        getPokemonDetail(pokemonList: suggestPokemon)
    }
    
    func clearSearch() {
        isSearch = false
        currentOffset = 0
        loadMorePokemon()
    }
    
    func didSelectPokemon(request: HomeModel.SelectPokemon.Request) {
        guard let urlString = pokemonDetailList.filter({$0.pokemonName == request.pokemonName}).first?.urlDetail else {
            self.presenter?.presentAlert(response: HomeModel.ShowAlert.Response(title: "Error", message: "Please try again"))
            return
        }
        presenter?.presentSelectPokemon(response: HomeModel.SelectPokemon.Response(urlString: urlString))
    }
}
