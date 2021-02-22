//
//  CharacterTableViewController.swift
//  iOS-Testing-API
//
//  Created by Rogério Fidelix on 17/02/21.
//  Copyright © 2021 Rogério Fidelix. All rights reserved.
//

import Foundation
import UIKit

class CharacterTableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView? {
        didSet {
            self.tableView?.keyboardDismissMode = .onDrag
        }
    }
    private var characterFactory: CharacterFactory?
    private let api = ApiCalls()
    
    private var searchController: UISearchController?
    
    lazy var viewModel: CharacterViewModel = {
        return CharacterViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RickAndMortyCharacters"
        initViewModel()
        setupSearchBar()
    }
    
    private func initViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.loadCharactersTable()
            }
        }
        viewModel.setCharacterData()
    }
    
    private func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.sizeToFit()
        searchController?.obscuresBackgroundDuringPresentation = false
        tableView?.tableHeaderView = searchController?.searchBar
        definesPresentationContext = true
    }
    
    private func loadCharactersTable() {
        guard let tv = self.tableView else { return }
        
        characterFactory = CharacterFactory(tableView: tv,
                                            delegate: self,
                                            search: searchController!)
        
        tv.delegate = self
        tv.dataSource = self
        characterFactory?.loadCells()
        tv.reloadData()
    }
}

extension CharacterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterCharacter(searchText: searchController.searchBar.text ?? "")
        self.loadCharactersTable()
    }
}

extension CharacterTableViewController: CharacterProtocol {
    func getFilteredCharacters() -> [Results] {
        return viewModel.filteredCharacters()
    }
    
    func getResult() -> CharacterModel {
        return viewModel.characterModel!
    }
}

extension CharacterTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterFactory?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return characterFactory?.cells[indexPath.row] ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharacterDetailsViewController()
        vc.characterId = String(indexPath.row + 1)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
