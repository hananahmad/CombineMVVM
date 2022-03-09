//
//  HomeChildCoordinator.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import Foundation
import UIKit

class HomeChildCoordinator : ChildCoordinator {

    weak var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController

    init(with _navigationController: UINavigationController){
        self.navigationController = _navigationController
    }

    func configureChildViewController() {
        let homeVC = LinkHistoryViewController()
        homeVC.homeChildCoordinator = self
        self.navigationController.pushViewController(homeVC, animated: true)
    }

    func passParameter(value: Decodable) {
//        guard let parameter = value as? LinkHistoryParameter else {return}
    }
}
