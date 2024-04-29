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
    var isShowShiny: Bool = false
    var pokemonDetail: DetailModel.GetPokemonDetail.PokemonDetailViewModel?
    
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
        statChart.centerText = "Stat"
        let centerText = NSMutableAttributedString(string: "Stat")
        centerText.setAttributes([.font : UIFont(name: "ChalkboardSE-Bold", size: 24) ?? UIFont(), .foregroundColor: UIColor.white], range: NSRange(location: 0, length: centerText.length))
        statChart.centerAttributedText = centerText
        statChart.legend.enabled = false
        statChart.drawCenterTextEnabled = true
        statChart.chartDescription.enabled = false
        statChart.centerTextRadiusPercent = 0.7
        statChart.drawHoleEnabled = true
        statChart.holeColor = .clear
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let shinyUrl = pokemonDetail?.imageShinyUrl, let normalUrl = pokemonDetail?.imageUrl else { return }
        if motion == .motionShake {
            if isShowShiny {
                let url = URL(string: normalUrl)
                pokemonImage.kf.setImage(with: url)
            } else {
                let url = URL(string: shinyUrl)
                pokemonImage.kf.setImage(with: url)
            }
            isShowShiny = !isShowShiny
        }
    }
    
    func displayPokemonDetail(viewModel: DetailModel.GetPokemonDetail.ViewModel) {
        view.hideLoading()
        pokemonDetail = viewModel.model
        pokemonNameLabel.text = "\(viewModel.model.name) #\(viewModel.model.id)"
        heightLabel.text = "Height: \(String(format: "%.2f", viewModel.model.height)) ft"
        weightLabel.text = "Weight: \(String(format: "%.2f", viewModel.model.weight)) lbs"
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
        data.setValueFont(UIFont(name: "ChalkboardSE-Bold", size: 12) ?? UIFont())
        data.setValueTextColor(UIColor.white)
        data.isHighlightEnabled = false
        data.dataSet?.drawValuesEnabled = true
        statChart.data = data
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
}
