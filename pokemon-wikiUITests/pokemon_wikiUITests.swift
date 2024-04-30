//
//  pokemon_wikiUITests.swift
//  pokemon-wikiUITests
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import XCTest

final class pokemon_wikiUITests: XCTestCase {
    let app = XCUIApplication()
    // Home page
    let searchView = XCUIApplication().textFields["txtSearch"]
    let collectionView = XCUIApplication().collectionViews["pokemonCollectionView"]
    // Detail page
    let navBarBulbasaur = XCUIApplication().navigationBars["bulbasaur #1"]
    
    override func setUp() {
        app.launch()
    }

    func testSeeHomePage() {
        XCTAssertTrue(searchView.exists)
        XCTAssertTrue(collectionView.exists)
    }
    
    func testSearchPokemon() {
        testSeeHomePage()
        searchView.tap()
        searchView.typeText("bulbasaur")
        wait(for: [], timeout: 5)
        XCTAssertEqual(1, collectionView.cells.count)
    }
    
    func testTapOnFirstPokemon() {
        testSeeHomePage()
        collectionView.cells.firstMatch.tap()
        XCTAssertTrue(navBarBulbasaur.exists)
    }
}
