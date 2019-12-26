//
//  HeroViewModel.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 20/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import Foundation

class HeroViewModel {
    
    private var heroes: [Hero] = []
    private var filteredHeroes: [Hero] = []
    
    var totalHero: Int = 0
    var offset: Int = 0
    var searchActive: Bool = false
    
    func numberOfRows(_ section: Int) -> Int {
        if searchActive {
            return self.filteredHeroes.count
        }
        return self.heroes.count
    }
    
    func heroAt(_ index: Int) -> Hero {
        if searchActive {
            return self.filteredHeroes[index]
        }
        return self.heroes[index]
    }
    
    func loadCharacters(offset: Int, completion: @escaping([Hero]) ->()) {
        let heroesUrl = "https://gateway.marvel.com/v1/public/characters"
        let heroesResource = Resource<HeroBase>(url: heroesUrl, offset: offset) { data in
            let heroData = try? JSONDecoder().decode(HeroBase.self, from: data)
            return heroData
        }
        
        NetworkingManager().load(resource: heroesResource) { result in
            if let heroData = result {
                self.updateHero(characters: heroData.data.results)
                self.totalHero = heroData.data.total
                completion(self.heroes)
            } else {
                completion([Hero]())
            }
            
        }
    }
    
    func searchByHeroName(name: String) {
        if !name.isEmpty {
            self.filteredHeroes = self.heroes.filter { (heroList) -> Bool in
                (heroList.name.lowercased().contains(name.lowercased()))
            }
            self.searchActive = true
        } else {
            self.searchActive = false
            self.filteredHeroes = self.heroes
        }
    }
    
    private func updateHero(characters: [Hero]) {
        for character in characters {
            if !self.heroes.contains(where: { $0.id == character.id }) {
                self.heroes.append(character)
            }
        }
    }
}
