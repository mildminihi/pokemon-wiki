//
//  DetailPresenterTests.swift
//  pokemon-wikiTests
//
//  Created by Supanat Wanroj on 30/4/2567 BE.
//

import XCTest
@testable import pokemon_wiki

final class DetailPresenterTests: XCTestCase {
    private var presenter: DetailPresenter!
    private var viewControllerSpy: DetailViewControllerSpy!
    
    private class DetailViewControllerSpy: DetailViewControllerInterface {
        var displayPokemonDetalCalled = false
        var displayAlertCalled = false
        
        func displayPokemonDetail(viewModel: pokemon_wiki.DetailModel.GetPokemonDetail.ViewModel) {
            displayPokemonDetalCalled = true
        }
        
        func displayAlert(viewModel: pokemon_wiki.DetailModel.ShowAlert.ViewModel) {
            displayAlertCalled = true
        }
    }
    
    override func setUp() {
        super.setUp()
        presenter = DetailPresenter()
        viewControllerSpy = DetailViewControllerSpy()
        presenter.viewController = viewControllerSpy
    }
    
    func testPresentPokemonDetailSuccess() {
        // Given
        let pokemonDetailResponse = PokemonDetailResponse(id: 1, locationAreaEncounters: "", name: "Pickachu", sprites: Sprites(backDefault: "", backFemale: "", backShiny: "", backShinyFemale: "", frontDefault: "", frontFemale: "", frontShiny: "", frontShinyFemale: ""), stats: [], types: [TypeElement(slot: 1, type: TypeClass(name: "normal", url: ""))], weight: 10, height: 10)
        
        // When
        presenter.presentPokemonDetail(response: DetailModel.GetPokemonDetail.Response(pokemonDetail: pokemonDetailResponse))
        
        // Then
        XCTAssertTrue(viewControllerSpy.displayPokemonDetalCalled)
    }
    
    func testPresentPokemonDetailFail() {
        // Given
        let response = DetailModel.ShowAlert.Response(title: "", message: "")
        
        // When
        presenter.presentAlert(response: response)
        
        // Then
        XCTAssertTrue(viewControllerSpy.displayAlertCalled)
    }
}
