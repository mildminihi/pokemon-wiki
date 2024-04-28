//
//  PokemonType.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 28/4/2567 BE.
//

import Foundation
import UIKit

enum PokemonType {
    case normal
    case fire
    case fighting
    case water
    case flying
    case grass
    case poison
    case electric
    case ground
    case psychic
    case rock
    case ice
    case bug
    case dragon
    case ghost
    case dark
    case steel
    case fairy
    
    var stringValue: String {
        switch self {
        case .normal:
            return "Normal"
        case .fire:
            return "Fire"
        case .fighting:
            return "Fighting"
        case .water:
            return "Water"
        case .flying:
            return "Flying"
        case .grass:
            return "grass"
        case .poison:
            return "Poison"
        case .electric:
            return "Electric"
        case .ground:
            return "Ground"
        case .psychic:
            return "Psychic"
        case .rock:
            return "Rock"
        case .ice:
            return "Ice"
        case .bug:
            return "Bug"
        case .dragon:
            return "Dragon"
        case .ghost:
            return "Ghost"
        case .dark:
            return "Dark"
        case .steel:
            return "Steel"
        case .fairy:
            return "Fairy"
        }
    }
    
    var typeColor: UIColor {
        switch self {
        case .normal:
            return UIColor(red: 159, green: 161, blue: 159, alpha: 1)
        case .fire:
            return UIColor(red: 229, green: 40, blue: 41, alpha: 1)
        case .fighting:
            return UIColor(red: 247, green: 128, blue: 2, alpha: 1)
        case .water:
            return UIColor(red: 47, green: 128, blue: 239, alpha: 1)
        case .flying:
            return UIColor(red: 129, green: 185, blue: 239, alpha: 1)
        case .grass:
            return UIColor(red: 63, green: 161, blue: 40, alpha: 1)
        case .poison:
            return UIColor(red: 145, green: 65, blue: 203, alpha: 1)
        case .electric:
            return UIColor(red: 249, green: 192, blue: 1, alpha: 1)
        case .ground:
            return UIColor(red: 145, green: 81, blue: 33, alpha: 1)
        case .psychic:
            return UIColor(red: 239, green: 65, blue: 121, alpha: 1)
        case .rock:
            return UIColor(red: 179, green: 169, blue: 129, alpha: 1)
        case .ice:
            return UIColor(red: 68, green: 206, blue: 243, alpha: 1)
        case .bug:
            return UIColor(red: 145, green: 161, blue: 27, alpha: 1)
        case .dragon:
            return UIColor(red: 80, green: 95, blue: 226, alpha: 1)
        case .ghost:
            return UIColor(red: 111, green: 64, blue: 112, alpha: 1)
        case .dark:
            return UIColor(red: 99, green: 77, blue: 77, alpha: 1)
        case .steel:
            return UIColor(red: 96, green: 161, blue: 184, alpha: 1)
        case .fairy:
            return UIColor(red: 239, green: 112, blue: 139, alpha: 1)
        }
    }
}
