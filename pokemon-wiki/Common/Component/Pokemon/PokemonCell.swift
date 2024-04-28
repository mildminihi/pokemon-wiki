//
//  PokemonCell.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation
import Kingfisher
import UIKit

struct PokemonCellViewModel {
    let imageUrl: String
    let pokemonName: String
}

class PokemonCell: UICollectionViewCell {
    static let identifier = "PokemonCell"
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var  containerView: UIView!
    
    func setData(with model: PokemonCellViewModel) {
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        pokemonNameLabel.text = model.pokemonName
        let url = URL(string: model.imageUrl)
        pokemonImage.kf.setImage(with: url)
    }
}
