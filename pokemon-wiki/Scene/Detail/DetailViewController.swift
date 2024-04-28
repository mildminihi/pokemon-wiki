//
//  DetailViewController.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 28/4/2567 BE.
//

import Foundation
import UIKit
import Kingfisher
import Charts

protocol DetailViewControllerInterface {
    func displayPokemonDetail(viewModel: DetailModel.GetPokemonDetail.ViewModel)
}

class DetailViewController: BaseViewController, DetailViewControllerInterface {
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var spAttackLabel: UILabel!
    @IBOutlet weak var spDefenseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    var typeList: [PokemonType] = []
    var interactor: DetailInteractorInterface?
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configulation()
        interactor?.getPokemonDetail(urlString: urlString ?? "")
        view.showLoading()
    }
    
    private func configulation() {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let worker = DetailWorker()
        presenter.viewController = self
        interactor.presenter = presenter
        interactor.worker = worker
        self.interactor = interactor
    }
    
    private func setupView() {
        typeCollectionView.dataSource = self
        typeCollectionView.delegate = self
        let nib = UINib(nibName: "TypeCell", bundle: nil)
        typeCollectionView.register(nib, forCellWithReuseIdentifier: TypeCell.identifier)
    }
    
    func displayPokemonDetail(viewModel: DetailModel.GetPokemonDetail.ViewModel) {
        view.hideLoading()
        pokemonNameLabel.text = "\(viewModel.model.name) #\(viewModel.model.id)"
        heightLabel.text = "Height: \(viewModel.model.height)"
        weightLabel.text = "Weight: \(viewModel.model.weight)"
        typeList = viewModel.model.type
        typeCollectionView.reloadData()
        let url = URL(string: viewModel.model.imageUrl)
        pokemonImage.kf.setImage(with: url)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.identifier, for: indexPath) as? TypeCell else {
            return UICollectionViewCell()
        }
        cell.setupType(type: typeList[indexPath.item])
        return cell
    }
    
    
}
