//
//  EndPointConstant.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 26/4/2567 BE.
//

import Foundation

enum EndPointConstant {
    case pokemon(_ id: Int? = nil)
    case fullUrl(url: String)
    
    var stringValue: String {
        switch self {
        case .pokemon(let id):
            guard let id = id else { return "pokemon"}
            return "pokemon/\(id)"
        case .fullUrl(let url): return url
        }
    }
}
