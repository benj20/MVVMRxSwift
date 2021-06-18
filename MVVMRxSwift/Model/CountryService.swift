//
//  CountryService.swift
//  MVVMRxSwift
//
//  Created by Benjamin Gouguet on 30/03/2021.
//

import Foundation
import RxSwift

class CountryService {
    
    static let shared = CountryService()
    private init() {}
    
    // https://restcountries.eu
    private let apiUrl = "https://restcountries.eu/rest/v2/region/"
    private var task: URLSessionDataTask?
    
    
    func fetchCountriesDetail(region: Region) -> Observable<[Country]> {
        
        return Observable.create { observer -> Disposable in
            let url = URL(string: self.apiUrl + region.rawValue)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let session = URLSession(configuration: .default)

            self.task?.cancel()
            self.task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        observer.onError(NSError(domain: "no data", code: -1, userInfo: nil))
                        return
                    }

                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        observer.onError(NSError(domain: "response invalid", code: -1, userInfo: nil))
                        return
                    }

                    do {
                        let countryDetail = try JSONDecoder().decode([Country].self, from: data)
                        observer.onNext(countryDetail)
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            self.task?.resume()

            return Disposables.create {
                self.task?.cancel()
            }
        }
    }
}
