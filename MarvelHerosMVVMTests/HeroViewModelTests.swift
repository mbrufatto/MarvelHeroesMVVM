//
//  HeroViewModelTests.swift
//  MarvelHerosMVVMTests
//
//  Created by Marcio Brufatto on 27/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import XCTest
@testable import MarvelHerosMVVM

class HeroViewModelTests: XCTestCase {

    private var heroViewModel: HeroViewModel!

    override func setUp() {
        super.setUp()
        heroViewModel = HeroViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFirstLoadOfHeroes() {
        heroViewModel.updateHero(characters: didLoadCharacters(nameFile: "FirstCharacters"))
        XCTAssertEqual(heroViewModel.numberOfRows(0), 20)
    }
    
    func testSecondLoadOfHeroes() {
        heroViewModel.updateHero(characters: didLoadCharacters(nameFile: "FirstCharacters"))
        heroViewModel.updateHero(characters: didLoadCharacters(nameFile: "SecondCharacters"))
        XCTAssertEqual(heroViewModel.numberOfRows(0), 40)
    }
    
    func testSelectAHero() {
        var heroName = ""
        heroViewModel.updateHero(characters: didLoadCharacters(nameFile: "FirstCharacters"))
        
        let hero = heroViewModel.heroAt(0)
        hero.name.bind { heroName = $0 }
        
        XCTAssertEqual(heroName, "3-D Man")
    }
    
    func testSearchHeroByName() {
        heroViewModel.updateHero(characters: didLoadCharacters(nameFile: "FirstCharacters"))
        heroViewModel.updateHero(characters: didLoadCharacters(nameFile: "SecondCharacters"))
        
        heroViewModel.searchByHeroName(name: "Man")
        
        XCTAssertEqual(heroViewModel.numberOfRows(0), 3)
    }
    
    private func didLoadCharacters(nameFile: String) -> [Hero] {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: nameFile, withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(HeroBase.self, from: data)
                return jsonData.data.results
            } catch {
                return []
            }
        }
        return []
    }
}
