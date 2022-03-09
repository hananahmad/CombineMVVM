//
//  MainCoordinator.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/23/22.
//

import Foundation
import UIKit

class MainCoordinator : ParentCoordinator {

    var navigationController: UINavigationController
    var childCoordinator: [ChildCoordinator] = [ChildCoordinator]()

    init(with _navigationController : UINavigationController){
        self.navigationController = _navigationController
    }

    func configureRootViewController() {

        let linkHistoryHomeChildCoordinator = ChildCoordinatorFactory.create(with: self.navigationController, type: .home)
        childCoordinator.append(linkHistoryHomeChildCoordinator)
        linkHistoryHomeChildCoordinator.parentCoordinator = self
        linkHistoryHomeChildCoordinator.configureChildViewController()
        
    }

    func removeChildCoordinator(child: ChildCoordinator) {
        for(index, coordinator) in childCoordinator.enumerated() {
            if(coordinator === child) {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
}
