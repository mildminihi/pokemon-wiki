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
    
    func fetchPokemonList() {
        presenter?.presentPokemonList()
    }
}
