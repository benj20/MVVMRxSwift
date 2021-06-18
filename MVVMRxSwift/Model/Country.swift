//
//  Country.swift
//  MVVMRxSwift
//
//  Created by Benjamin Gouguet on 30/03/2021.
//

import Foundation

struct Country: Decodable {
    let name: String
    let population: Int
    let flag: String
    let translations: Translation
}

struct Translation: Decodable {
    let fr: String?
}

enum Region: String {
    case Africa
    case Americas
    case Asia
    case Europe
    case Oceania
    
    var frName: String {
        switch self {
        case .Africa:
            return "Afrique"
        case .Americas:
            return "Amérique"
        case .Asia:
            return "Asie"
        case .Europe:
            return "Europe"
        case .Oceania:
            return "Océanie"
        }
    }

    static let all = [Africa, Americas, Asia, Europe, Oceania]
}

enum Sort: Int {
    case alphabetical = 0
    case decreasing
    case increasing
}

