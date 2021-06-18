//
//  CountriesListViewModel.swift
//  MVVMRxSwift
//
//  Created by Benjamin Gouguet on 30/03/2021.
//

import Foundation
import RxSwift

class CountriesListViewModel {

    func fetchCountryViewModels(region : Region) -> Observable<[CountryDetailViewModel]> {
        CountryService.shared.fetchCountriesDetail(region: region).map {
            $0.map {
                CountryDetailViewModel(country: $0)
            }
        }
    }
}
