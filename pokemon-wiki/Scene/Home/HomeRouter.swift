//
//  HomeRouter.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import Foundation
import UIKit

protocol HomeRouterInterface {
    func navigateToPokemonDetail(urlDetail: String)
}

class HomeRouter: HomeRouterInterface {
    weak var viewController: UIViewController?
    
    func navigateToPokemonDetail(urlDetail: String) {
        let destination = DetailViewController(nibName: "DetailViewController", bundle: nil)
        destination.urlString = urlDetail
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
