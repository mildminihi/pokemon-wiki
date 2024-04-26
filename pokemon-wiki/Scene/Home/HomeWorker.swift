//
//  HomeWorker.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation

protocol HomeWorkerInterface {
    func getPokemonList(offset: Int, completion: @escaping (Result<PokemonResponse, ResponseError>) -> Void)
}

class HomeWorker: HomeWorkerInterface {
    func getPokemonList(offset: Int, completion: @escaping (Result<PokemonResponse, ResponseError>) -> Void) {
        let parameters: [String: Any] = ["offset": offset, "limit": 20]
        Rest.shared.request(.pokemon, parameters: parameters) { (result: Result<PokemonResponse, ResponseError>) in
            switch result {
            case .success(let result):
                print(result)
                completion(.success(result))
            case .failure(let error):
                print(error)
            }
        }
    }
}
