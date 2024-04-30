//
//  HomeInteractorTests.swift
//  pokemon-wikiTests
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import XCTest
@testable import pokemon_wiki

final class HomeInteractorTests: XCTestCase {
    
    private var interactor: HomeInteractor!
    private var presenterSpy: HomePresenterSpy!
    private var workerSpy: HomeWorkerSpy!
    
    private class HomePresenterSpy: HomePresenterInterface {
        var presentPokemonListCalled: Bool = false
        var presentAlertCalled: Bool = false
        var presentSelectPokemonCalled: Bool = false
        
        func presentPokemonList(response: pokemon_wiki.HomeModel.FetchPokemonList.Response) {
            presentPokemonListCalled = true
        }
        
        func presentAlert(response: pokemon_wiki.HomeModel.ShowAlert.Response) {
            presentAlertCalled = true
        }
        
        func presentSelectPokemon(response: pokemon_wiki.HomeModel.SelectPokemon.Response) {
            presentSelectPokemonCalled = true
        }
    }
    
    private class HomeWorkerSpy: HomeWorkerInterface {
        var isForceFail = false
        
        func getAllPokemonList(offset: Int, completion: @escaping (Result<pokemon_wiki.PokemonResponse, pokemon_wiki.ResponseError>) -> Void) {
            if !isForceFail {
                let pokemonResult = [
                    PokemonResult(name: "bulbasaur", url: ""),
                    PokemonResult(name: "ivysaur", url: ""),
                    PokemonResult(name: "venusaur", url: ""),
                    PokemonResult(name: "charmander", url: ""),
                    PokemonResult(name: "charmeleon", url: ""),
                    PokemonResult(name: "charizard", url: ""),
                    PokemonResult(name: "squirtle", url: ""),
                    PokemonResult(name: "wartortle", url: ""),
                    PokemonResult(name: "bulbasaur", url: ""),
                    PokemonResult(name: "blastoise", url: ""),
                    PokemonResult(name: "caterpie", url: ""),
                    PokemonResult(name: "metapod", url: ""),
                    PokemonResult(name: "butterfree", url: ""),
                    PokemonResult(name: "weedle", url: ""),
                    PokemonResult(name: "kakuna", url: ""),
                    PokemonResult(name: "beedrill", url: "")]
                completion(.success(PokemonResponse(count: 16, next: "", previous: "", results: pokemonResult)))
            } else {
                completion(.failure(ResponseError(responseCode: nil, errorMessage: nil)))
            }
        }
        
        func getPokemonDetail(url: String, completion: @escaping (Result<pokemon_wiki.PokemonDetailResponse, pokemon_wiki.ResponseError>) -> Void) {
            if !isForceFail {
                let pokemonDetailResult = PokemonDetailResponse(id: 1, locationAreaEncounters: "", name: "Pickachu", sprites: Sprites(backDefault: "", backFemale: "", backShiny: "", backShinyFemale: "", frontDefault: "", frontFemale: "", frontShiny: "", frontShinyFemale: ""), stats: [], types: [TypeElement(slot: 1, type: TypeClass(name: "normal", url: ""))], weight: 10, height: 10)
                completion(.success(pokemonDetailResult))
            } else {
                completion(.failure(ResponseError(responseCode: nil, errorMessage: nil)))
            }
        }
    }
    
    override func setUp() {
        super.setUp()
        interactor = HomeInteractor()
        presenterSpy = HomePresenterSpy()
        workerSpy = HomeWorkerSpy()
        interactor.worker = workerSpy
        interactor.presenter = presenterSpy
    }

    func testGetPokemonListFail() {
        // Given
        workerSpy.isForceFail = true
        
        // When
        interactor.fetchPokemonList()
        
        // Then
        XCTAssertTrue(presenterSpy.presentAlertCalled)
    }
    
    func testSearchPokemonSuccess() {
        // Given
        interactor.pokemonDetailList = [HomeModel.FetchPokemonList.PokemonListViewModel(pokemonName: "bulbasaur", urlDetail: "")]
        workerSpy.isForceFail = false
        
        // When
        interactor.didSelectPokemon(request: HomeModel.SelectPokemon.Request(pokemonName: "bulbasaur"))
        
        // Then
        XCTAssertTrue(presenterSpy.presentSelectPokemonCalled)
    }
    
    func testSearchPokemonFail() {
        // Given
        workerSpy.isForceFail = true
        
        // When
        interactor.didSelectPokemon(request: HomeModel.SelectPokemon.Request(pokemonName: "bulbasaur"))
        
        // Then
        XCTAssertTrue(presenterSpy.presentAlertCalled)
    }

}
