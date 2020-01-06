//
//  ComicViewModelTests.swift
//  MarvelHerosMVVMTests
//
//  Created by Marcio Brufatto on 06/01/20.
//  Copyright © 2020 Marcio Brufatto. All rights reserved.
//

import XCTest
@testable import MarvelHerosMVVM

class ComicViewModelTests: XCTestCase {

    private var comicViewModel: ComicViewModel!
    
    override func setUp() {
        super.setUp()
        comicViewModel = ComicViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testAddComics() {
        comicViewModel.addComics(comics: didLoadComics(nameFile: "Comics"))
        XCTAssertEqual(comicViewModel.numberOfRows(0), 12)
    }
    
    func testeSelectesComic() {
        comicViewModel.addComics(comics: didLoadComics(nameFile: "Comics"))
        let comic = comicViewModel.comicAt(2)
        
        XCTAssertEqual(comic.title, "Avengers: The Initiative (2007) #18")
    }
    
    private func didLoadComics(nameFile: String) -> [Comic] {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: nameFile, withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ComicBase.self, from: data)
                return jsonData.data.results
            } catch {
                return []
            }
        }
        return []
    }
}
