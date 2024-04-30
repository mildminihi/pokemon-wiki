//
//  HomePresentTests.swift
//  pokemon-wikiTests
//
//  Created by Supanat Wanroj on 30/4/2567 BE.
//

import XCTest
@testable import pokemon_wiki

final class HomePresentTests: XCTestCase {
    
    private var presenter: HomePresenter!
    private var viewControllerSpy: HomeViewControllerSpy!
    
    private class HomeViewControllerSpy: HomeViewControllerInterface {
        var displayPokemonListCalled: Bool = false
        var displayAlertCalled: Bool = false
        var displaySelectPokemonCalled: Bool = false
        
        func displayPokemonList(viewModel: pokemon_wiki.HomeModel.FetchPokemonList.ViewModel) {
            displayPokemonListCalled = true
        }
        
        func displayAlert(viewModel: pokemon_wiki.HomeModel.ShowAlert.ViewModel) {
            displayAlertCalled = true
        }
        
        func displaySelectPokemon(viewModel: pokemon_wiki.HomeModel.SelectPokemon.ViewModel) {
            displaySelectPokemonCalled = true
        }
    }
    
    override func setUp() {
        super.setUp()
        presenter = HomePresenter()
        viewControllerSpy = HomeViewControllerSpy()
        presenter.viewController = viewControllerSpy
    }
    
    func testPresentPokemonListSuccess() {
        // Given
        let pokemonList = PokemonCellViewModel(imageUrl: "", pokemonName: "Eevee")
        
        // When
        presenter.presentPokemonList(response: HomeModel.FetchPokemonList.Response(pokemonList: [pokemonList]))
        
        // Then
        XCTAssertTrue(viewControllerSpy.displayPokemonListCalled)
    }
    
    func testPresentPokemonListFail() {
        // Given
        let response = HomeModel.ShowAlert.Response(title: "", message: "")
        
        // When
        presenter.presentAlert(response: response)
        
        // Then
        XCTAssertTrue(viewControllerSpy.displayAlertCalled)
    }
    
    func testPresentSelectPokemon() {
        // Given
        let response = HomeModel.SelectPokemon.Response(urlString: "")
        
        // When
        presenter.presentSelectPokemon(response: response)
        
        // Then
        XCTAssertTrue(viewControllerSpy.displaySelectPokemonCalled)
    }
}
