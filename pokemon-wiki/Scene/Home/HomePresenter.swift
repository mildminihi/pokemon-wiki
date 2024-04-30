//
//  HomePresenter.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation

protocol HomePresenterInterface {
    func presentPokemonList(response: HomeModel.FetchPokemonList.Response)
    func presentAlert(response: HomeModel.ShowAlert.Response)
    func presentSelectPokemon(response: HomeModel.SelectPokemon.Response)
}

class HomePresenter: HomePresenterInterface {
    var viewController: HomeViewControllerInterface?
    
    func presentPokemonList(response: HomeModel.FetchPokemonList.Response) {
        viewController?.displayPokemonList(viewModel: HomeModel.FetchPokemonList.ViewModel(pokemonList: response.pokemonList))
    }
    
    func presentAlert(response: HomeModel.ShowAlert.Response) {
        viewController?.displayAlert(viewModel: HomeModel.ShowAlert.ViewModel(title: response.title, message: response.message))
    }
    
    func presentSelectPokemon(response: HomeModel.SelectPokemon.Response) {
        viewController?.displaySelectPokemon(viewModel: HomeModel.SelectPokemon.ViewModel(urlString: response.urlString))
    }
}
