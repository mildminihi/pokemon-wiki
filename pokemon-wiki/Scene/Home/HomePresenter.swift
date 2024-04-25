//
//  HomePresenter.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation

protocol HomePresenterInterface {
    func presentPokemonList()
}

class HomePresenter: HomePresenterInterface {
    weak var viewController: HomeViewController?
    
    func presentPokemonList() {
        let mockData: [PokemonCellViewModel] = [PokemonCellViewModel(imageUrl: "", pokemonName: "eiei1"),
                                                PokemonCellViewModel(imageUrl: "", pokemonName: "eiei2"),
                                                PokemonCellViewModel(imageUrl: "", pokemonName: "eiei3"),
                                                PokemonCellViewModel(imageUrl: "", pokemonName: "eiei4")]
        viewController?.displayPokemonList(viewModel: HomeModel.FetchPokemonList.ViewModel(pokemonList: mockData))
    }
}
