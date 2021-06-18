//
//  CountriesDetailViewController.swift
//  MVVMRxSwift
//
//  Created by Benjamin Gouguet on 30/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class CountriesDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    let disposeBag = DisposeBag()
    var countriesList: BehaviorRelay<[CountryDetailViewModel]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countriesList.bind(to: tableView.rx.items(cellIdentifier: "Cell")) {(index, viewModel, cell) in
            cell.textLabel?.text = viewModel.displayTitle
            cell.detailTextLabel?.text = viewModel.displayDetail
        }.disposed(by: disposeBag)
        
        segmentedControl.rx.value.subscribe(onNext: {
            var countriesListViewModel = self.countriesList.value
            let sort = Sort(rawValue: $0) ?? .alphabetical
            switch sort {
            case .alphabetical:
                countriesListViewModel.sort {
                    $0.displayTitle < $1.displayTitle
                }
            case .decreasing:
                countriesListViewModel.sort {
                    $0.population > $1.population
                }
            case .increasing:
                countriesListViewModel.sort {
                    $0.population < $1.population
                }
            }
            
            self.countriesList.accept(countriesListViewModel)
        }).disposed(by: disposeBag)
    }
}
