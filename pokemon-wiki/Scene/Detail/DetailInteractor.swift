//
//  DetailInteractor.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 28/4/2567 BE.
//

import Foundation

protocol DetailInteractorInterface {
    func getPokemonDetail(urlString: String)
}

class DetailInteractor: DetailInteractorInterface {
    var worker: DetailWorker?
    var presenter: DetailPresenter?
    
    var urlString: String?
    
    func getPokemonDetail(urlString: String) {
        worker?.getPokemonDetail(url: urlString, completion: { response in
            switch response {
            case .success(let result):
                self.presenter?.presentPokemonDetail(response: DetailModel.GetPokemonDetail.Response(pokemonDetail: result))
            case .failure(let failure):
                print(failure)
            }
        })
    }
}
