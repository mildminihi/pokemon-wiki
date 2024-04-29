//
//  TypeCell.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 28/4/2567 BE.
//

import Foundation
import UIKit

class TypeCell: UICollectionViewCell {
    static let identifier = "TypeCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    func setupType(type: PokemonType) {
        containerView.layer.cornerRadius = 30
        containerView.layer.masksToBounds = true
        typeLabel.text = type.stringValue
        containerView.backgroundColor = type.typeColor
    }
}
