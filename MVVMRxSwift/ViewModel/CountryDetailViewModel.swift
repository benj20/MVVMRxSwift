//
//  CountryDetailViewModel.swift
//  MVVMRxSwift
//
//  Created by Benjamin Gouguet on 30/03/2021.
//

import Foundation
import UIKit

struct CountryDetailViewModel {
    
    private let country: Country
    
    var displayTitle: String {
        return country.translations.fr ?? country.name
    }
    var displayDetail: String {
        return "Population : \(country.population.formattedWithSeparator)"
    }
    var population: Int {
        return country.population
    }
    
    init(country: Country) {
        self.country = country
    }
}
