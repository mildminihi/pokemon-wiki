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
    @IBOutlet weak var statChart: PieChartView!
    
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
        statChart.drawHoleEnabled = true
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
        setupStatChart(statList: viewModel.model.stat)
    }
    
    private func setupStatChart(statList: [DetailModel.GetPokemonDetail.StatDetail]) {
        let entries: [PieChartDataEntry] = statList.map { stat in
            return PieChartDataEntry(value: Double(stat.value), label: stat.statName)
        }
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.colorful()
        set.colors.append(NSUIColor(red: 54/255.0, green: 96/255.0, blue: 179/255.0, alpha: 1.0))
        set.drawValuesEnabled = false
        let data = PieChartData(dataSet: set)
        statChart.drawCenterTextEnabled = true
        statChart.chartDescription.enabled = false
        statChart.centerText = "Stat"
        statChart.data = data
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
