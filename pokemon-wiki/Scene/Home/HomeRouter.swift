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
        viewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        viewController?.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
