//
//  CharacterViewModel.swift
//  iOS-Testing-API
//
//  Created by Rogério Fidelix on 21/02/21.
//  Copyright © 2021 Rogério Fidelix. All rights reserved.
//

import Foundation

class CharacterViewModel {
    var reloadTableViewClosure: (() -> ())?
    
    private let api: ApiCalls
    
    private var filteredCharactersArray = [Results]()
    
    var characterModel: CharacterModel? {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    init(api: ApiCalls = ApiCalls()) {
        self.api = api
    }
    
    deinit {
        setCharacterData()
    }
    
    func setCharacterData() {
        api.fetchCharacters { [weak self] (character) in
            self?.characterModel = character
        }
    }
    
    func filterCharacter(searchText: String) {
        var applyFilter = characterModel?.results
        
        applyFilter = applyFilter?.filter({
            ($0.name?.contains(searchText) ?? false)
        })
        
        filteredCharactersArray = applyFilter ?? []
    }
    
    func filteredCharacters() -> [Results] {
        return filteredCharactersArray
    }
}
