//
//  DetailInteractorTests.swift
//  pokemon-wikiTests
//
//  Created by Supanat Wanroj on 30/4/2567 BE.
//

import XCTest
@testable import pokemon_wiki

final class DetailInteractorTests: XCTestCase {
    private var interactor: DetailInteractor!
    private var presenterSpy: DetailPresenterSpy!
    private var workerSpy: DetailWorkerSpy!
    
    class DetailPresenterSpy: DetailPresenterInterface {
        var presentPokemonDetailCalled = false
        var presentAlertCalled = false
        
        func presentPokemonDetail(response: pokemon_wiki.DetailModel.GetPokemonDetail.Response) {
            presentPokemonDetailCalled = true
        }
        
        func presentAlert(response: pokemon_wiki.DetailModel.ShowAlert.Response) {
            presentAlertCalled = true
        }
    }
    
    class DetailWorkerSpy: DetailWorkerInterface {
        var isForceFail = false
        
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
        interactor = DetailInteractor()
        presenterSpy = DetailPresenterSpy()
        workerSpy = DetailWorkerSpy()
        interactor.worker = workerSpy
        interactor.presenter = presenterSpy
    }
    
    func testGetPokemonDetailSuccess() {
        // Given
        let pokemonUrl = ""
        workerSpy.isForceFail = false
        
        // When
        interactor.getPokemonDetail(urlString: "")
        
        // Then
        XCTAssertTrue(presenterSpy.presentPokemonDetailCalled)
    }
    
    func testGetPokemonDetailFail() {
        // Given
        let pokemonUrl = ""
        workerSpy.isForceFail = true
        
        // When
        interactor.getPokemonDetail(urlString: "")
        
        // Then
        XCTAssertFalse(presenterSpy.presentPokemonDetailCalled)
        XCTAssertTrue(presenterSpy.presentAlertCalled)
    }
}
