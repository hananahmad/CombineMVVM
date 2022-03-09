//
//  ChildCoordinatorFactory.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import Foundation
import UIKit

enum childCoordinatorType {
    case home
}

class ChildCoordinatorFactory {
    static func create(with _navigationController: UINavigationController, type: childCoordinatorType) -> ChildCoordinator {

        switch type {
        case .home:
            return HomeChildCoordinator(with: _navigationController)
        }


    }
}
