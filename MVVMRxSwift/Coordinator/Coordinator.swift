//
//  Coordinator.swift
//  MVVMRxSwift
//
//  Created by Benjamin Gouguet on 30/03/2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
