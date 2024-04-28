//
//  DetailWorker.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 28/4/2567 BE.
//

import Foundation

protocol DetailWorkerInterface {
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetailResponse, ResponseError>) -> Void)
}

class DetailWorker: DetailWorkerInterface {
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
