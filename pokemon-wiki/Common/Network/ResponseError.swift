//
//  ResponseError.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 26/4/2567 BE.
//

import Foundation

struct ResponseError: Error, Equatable {
    let responseCode: Int?
    let errorMessage: String?
}
