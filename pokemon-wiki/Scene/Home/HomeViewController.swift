//
//  HomeViewController.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import UIKit

protocol HomeViewControllerInterface {
    func displayPokemonList(viewModel: HomeModel.FetchPokemonList.ViewModel)
}

class HomeViewController: UIViewController, HomeViewControllerInterface {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            let nib = UINib(nibName: "PokemonCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: PokemonCell.pokemonCellIdentifier)
        }
    }
    
    var interactor: HomeInteractorInterface?
    var router: HomeRouterInterface?
    
    var pokemonList: [PokemonCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configulation()
        interactor?.fetchPokemonList()
    }
    
    private func configulation() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        presenter.viewController = self
        interactor.presenter = presenter
        self.interactor = interactor
        router = HomeRouter()
    }
    
    func displayPokemonList(viewModel: HomeModel.FetchPokemonList.ViewModel) {
        pokemonList = viewModel.pokemonList
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokemonCell.pokemonCellIdentifier,
            for: indexPath) as? PokemonCell else { return UICollectionViewCell() }
        cell.setData(with: pokemonList[indexPath.row])
        return cell
    }
}
