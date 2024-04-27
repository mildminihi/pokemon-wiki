//
//  Rest.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 26/4/2567 BE.
//

import Foundation
import Alamofire

final class Rest {
    
    static let shared = Rest()
    private init() {}
    
    func request<T: Decodable>(_ endPoint: EndPointConstant, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, ResponseError>) -> Void) {
        var urlString = ""
        switch endPoint {
        case .fullUrl(let url):
            urlString = url
        default: urlString = "https://pokeapi.co/api/v2/\(endPoint.stringValue)"
        }
        
        print("👾 EndPoint ---> \(urlString)")
        AF.request(urlString, method: method, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                case .success(let value):
                    print("😍 Result Success ---> \(value)")
                    completion(.success(value))
                case .failure(let error):
                    print("🤮 Result Fail ---> \(error)")
                    completion(.failure(ResponseError(responseCode: error.responseCode, errorMessage: error.errorDescription)))
                }
            }
    }
}
