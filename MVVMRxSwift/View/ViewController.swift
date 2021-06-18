//
//  ViewController.swift
//  MVVMRxSwift
//
//  Created by Benjamin Gouguet on 30/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var regionPickerView: UIPickerView!
    
    weak var coordinator: MainCoordinator?
    let disposeBag = DisposeBag()
    var regions: BehaviorRelay<[Region]> = BehaviorRelay(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Population"
        navigationItem.backButtonTitle = ""
       
        regions.bind(to: regionPickerView.rx.itemTitles) {(row, element) in
            return element.frName
        }.disposed(by: disposeBag)
    }


    @IBAction func CountriesTapped(_ sender: Any) {
        let region = Region.all[regionPickerView.selectedRow(inComponent: 0)]
        coordinator?.countriesDetail(region: region)
    }
}

