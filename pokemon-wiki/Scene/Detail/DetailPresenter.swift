//
//  DetailPresenter.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 28/4/2567 BE.
//

import Foundation

protocol DetailPresenterInterface {
    func presentPokemonDetail(response: DetailModel.GetPokemonDetail.Response)
    func presentAlert(response: DetailModel.ShowAlert.Response)
}

class DetailPresenter: DetailPresenterInterface {
    var viewController: DetailViewControllerInterface?
    
    func presentPokemonDetail(response: DetailModel.GetPokemonDetail.Response) {
        let typeList: [PokemonType] = response.pokemonDetail.types.map { type in
            return PokemonType(rawValue: type.type.name) ?? .normal
        }
        let statList: [DetailModel.GetPokemonDetail.StatDetail] = response.pokemonDetail.stats.map { stat in
            if stat.stat.name == "special-defense" {
                return DetailModel.GetPokemonDetail.StatDetail(statName: "SP.DEF", value: stat.baseStat)
            } else if stat.stat.name == "special-attack" {
                return DetailModel.GetPokemonDetail.StatDetail(statName: "SP.ATK", value: stat.baseStat)
            }
            return DetailModel.GetPokemonDetail.StatDetail(statName: stat.stat.name.uppercased(), value: stat.baseStat)
        }
        let viewModel = DetailModel.GetPokemonDetail.PokemonDetailViewModel(name: response.pokemonDetail.name, imageUrl: response.pokemonDetail.sprites.frontDefault ?? "", imageShinyUrl: response.pokemonDetail.sprites.frontShiny, id: response.pokemonDetail.id, type: typeList, weight: Double(response.pokemonDetail.weight) / 4.536, height: Double(response.pokemonDetail.height) / 3.048, stat: statList)
        viewController?.displayPokemonDetail(viewModel: DetailModel.GetPokemonDetail.ViewModel(model: viewModel))
    }
    
    func presentAlert(response: DetailModel.ShowAlert.Response) {
        viewController?.displayAlert(viewModel: DetailModel.ShowAlert.ViewModel(title: response.title, message: response.message))
    }
}
