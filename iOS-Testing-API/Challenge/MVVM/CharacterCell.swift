//
//  CharacterCell.swift
//  iOS-Testing-API
//
//  Created by Rogério Fidelix on 17/02/21.
//  Copyright © 2021 Rogério Fidelix. All rights reserved.
//

import Foundation
import UIKit

class CharacterCell: UITableViewCell {
    @IBOutlet private weak var characterImage: UIImageView?
    @IBOutlet private weak var characterLabel:  UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(characterImageURL: String, characterLabel: String) {
        
        self.characterImage?.downloaded(from: characterImageURL)
        self.characterLabel?.text = characterLabel
    }
}
