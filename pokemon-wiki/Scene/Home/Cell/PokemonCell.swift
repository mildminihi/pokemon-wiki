//
//  PokemonCell.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation
import UIKit

struct PokemonCellViewModel {
    let imageUrl: String
    let pokemonName: String
}

class PokemonCell: UICollectionViewCell {
    static let pokemonCellIdentifier = "PokemonCell"
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    func setData(with modal: PokemonCellViewModel) {
        pokemonNameLabel.text = modal.pokemonName
    }
}
