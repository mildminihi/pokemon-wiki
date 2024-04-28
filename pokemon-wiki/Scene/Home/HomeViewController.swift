//
//  HomeViewController.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 25/4/2567 BE.
//

import UIKit

protocol HomeViewControllerInterface {
    func displayPokemonList(viewModel: HomeModel.FetchPokemonList.ViewModel)
    func displayAlert(viewModel: HomeModel.ShowAlert.ViewModel)
    func displaySelectPokemon(viewModel: HomeModel.SelectPokemon.ViewModel)
}

class HomeViewController: BaseViewController, HomeViewControllerInterface {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var interactor: HomeInteractorInterface?
    var router: HomeRouterInterface?
    
    var pokemonList: [PokemonCellViewModel] = []
    var isSearch: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configulation()
        setupView()
        interactor?.fetchPokemonList()
        view.showLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configulation() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let worker = HomeWorker()
        let router = HomeRouter()
        presenter.viewController = self
        interactor.presenter = presenter
        interactor.worker = worker
        router.viewController = self
        self.interactor = interactor
        self.router = router
    }
    
    private func setupView() {
        searchTextField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "PokemonCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PokemonCell.identifier)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func displayPokemonList(viewModel: HomeModel.FetchPokemonList.ViewModel) {
        view.hideLoading()
        if !viewModel.pokemonList.isEmpty {
            emptyLabel.isHidden = true
            collectionView.isHidden = false
            pokemonList = viewModel.pokemonList
            collectionView.reloadData()
        } else {
            emptyLabel.isHidden = false
            collectionView.isHidden = true
            pokemonList = []
            collectionView.reloadData()
        }
        view.layoutIfNeeded()
    }
    
    func displayAlert(viewModel: HomeModel.ShowAlert.ViewModel) {
        showAlert(title: viewModel.title, message: viewModel.message)
        view.hideLoading()
    }
    
    func displaySelectPokemon(viewModel: HomeModel.SelectPokemon.ViewModel) {
        router?.navigateToPokemonDetail(urlDetail: viewModel.urlString)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokemonCell.identifier,
            for: indexPath) as? PokemonCell else { return UICollectionViewCell() }
        cell.setData(with: pokemonList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width / 2) - 16
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == pokemonList.count - 2 && !isSearch {
            interactor?.loadMorePokemon()
            view.showLoading()
        }
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didSelectPokemon(request: HomeModel.SelectPokemon.Request(pokemonName: pokemonList[indexPath.row].pokemonName))
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        if newText.isEmpty {
            isSearch = false
            interactor?.clearSearch()
        }
        if newText.count >= 3 {
            isSearch = true
            interactor?.searchSuggestion(request: HomeModel.ShowSearchSuggestion.Request(text: newText))
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
