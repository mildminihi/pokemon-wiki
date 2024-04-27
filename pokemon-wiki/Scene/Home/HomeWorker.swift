//
//  HomeWorker.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation

protocol HomeWorkerInterface {
    func getPokemonList(offset: Int, completion: @escaping (Result<PokemonResponse, ResponseError>) -> Void)
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetailResponse, ResponseError>) -> Void)
}

class HomeWorker: HomeWorkerInterface {
    func getPokemonList(offset: Int, completion: @escaping (Result<PokemonResponse, ResponseError>) -> Void) {
        let parameters: [String: Any] = ["offset": offset, "limit": 20]
        Rest.shared.request(.pokemon(nil), parameters: parameters) { (result: Result<PokemonResponse, ResponseError>) in
            switch result {
            case .success(let result):
                print(result)
                completion(.success(result))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetailResponse, ResponseError>) -> Void) {
        Rest.shared.request(.fullUrl(url: url)) { (result: Result<PokemonDetailResponse, ResponseError>) in
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
