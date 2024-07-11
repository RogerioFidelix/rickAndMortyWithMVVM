//
//  CharacterFactory.swift
//  iOS-Testing-API
//
//  Created by Rogério Fidelix on 17/02/21.
//  Copyright © 2021 Rogério Fidelix. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterProtocol {
    func getResult() -> CharacterModel?
    func getFilteredCharacters() -> [Results]
}

class CharacterFactory {
    var cells: [UITableViewCell] = []
    private let tableView: UITableView?
    private var delegate: CharacterProtocol?
    private var search: UISearchController?
    
    init(tableView: UITableView,
         delegate: CharacterProtocol,
         search: UISearchController) {
        self.tableView = tableView
        self.delegate = delegate
        self.search = search
    }
    
    func loadCells() {
        registerCell()
        self.cells.append(contentsOf: loadCharacterCells())
    }
    
    private func registerCell() {
        tableView?.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "characterCell")
    }
    
    private func loadCharacterCells() -> [UITableViewCell] {
        var characterCells: [UITableViewCell] = []
        
        if search?.isActive ?? false && search?.searchBar.text != "" {
            
            if let filter = delegate?.getFilteredCharacters() {
                for character in filter {
                    if let characterCell = tableView?.dequeueReusableCell(withIdentifier: "characterCell") as? CharacterCell {

                        characterCell.setupCell(characterImageURL: character.image ?? "",
                                                characterLabel: character.name ?? "")

                        characterCells.append(characterCell)
                    }
                }
            }
            
        } else {
            
            if let loopResults = delegate?.getResult()?.results {
                for loop in loopResults {
                    if let characterCell = tableView?.dequeueReusableCell(withIdentifier: "characterCell") as? CharacterCell {

                        characterCell.setupCell(characterImageURL: loop.image ?? "",
                                                characterLabel: loop.name ?? "")

                        characterCells.append(characterCell)
                    }
                }
            }
            
        }
        return characterCells
    }
}
