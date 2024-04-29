//
//  PokemonType.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 28/4/2567 BE.
//

import Foundation
import UIKit

enum PokemonType: String {
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
            return "Grass"
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
            return UIColor(red: 159/255.0, green: 161/255.0, blue: 159/255.0, alpha: 1)
        case .fire:
            return UIColor(red: 229/255.0, green: 40/255.0, blue: 41/255.0, alpha: 1)
        case .fighting:
            return UIColor(red: 247/255.0, green: 128/255.0, blue: 2/255.0, alpha: 1)
        case .water:
            return UIColor(red: 47/255.0, green: 128/255.0, blue: 239/255.0, alpha: 1)
        case .flying:
            return UIColor(red: 129/255.0, green: 185/255.0, blue: 239/255.0, alpha: 1)
        case .grass:
            return UIColor(red: 63/255.0, green: 161/255.0, blue: 40/255.0, alpha: 1)
        case .poison:
            return UIColor(red: 145/255.0, green: 65/255.0, blue: 203/255.0, alpha: 1)
        case .electric:
            return UIColor(red: 249/255.0, green: 192/255.0, blue: 1/255.0, alpha: 1)
        case .ground:
            return UIColor(red: 145/255.0, green: 81/255.0, blue: 33/255.0, alpha: 1)
        case .psychic:
            return UIColor(red: 239/255.0, green: 65/255.0, blue: 121/255.0, alpha: 1)
        case .rock:
            return UIColor(red: 179/255.0, green: 169/255.0, blue: 129/255.0, alpha: 1)
        case .ice:
            return UIColor(red: 68/255.0, green: 206/255.0, blue: 243/255.0, alpha: 1)
        case .bug:
            return UIColor(red: 145/255.0, green: 161/255.0, blue: 27/255.0, alpha: 1)
        case .dragon:
            return UIColor(red: 80/255.0, green: 95/255.0, blue: 226/255.0, alpha: 1)
        case .ghost:
            return UIColor(red: 111/255.0, green: 64/255.0, blue: 112/255.0, alpha: 1)
        case .dark:
            return UIColor(red: 99/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)
        case .steel:
            return UIColor(red: 96/255.0, green: 161/255.0, blue: 184/255.0, alpha: 1)
        case .fairy:
            return UIColor(red: 239/255.0, green: 112/255.0, blue: 139/255.0, alpha: 1)
        }
    }
}
