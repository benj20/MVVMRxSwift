//
//  MainCoordinator.swift
//  MVVMRxSwift
//
//  Created by Benjamin Gouguet on 30/03/2021.
//

import Foundation
import UIKit
import RxSwift

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        vc.regions.accept(Region.all)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func countriesDetail(region: Region) {
        let vc = CountriesDetailViewController.instantiate()
        vc.coordinator = self
        vc.title = region.frName
        CountriesListViewModel().fetchCountryViewModels(region: region).subscribe { countriesListViewModel in
            vc.countriesList.accept(countriesListViewModel.sorted {
                $0.displayTitle < $1.displayTitle
            })
        }.disposed(by: disposeBag)
        navigationController.pushViewController(vc, animated: true)
    }
}
